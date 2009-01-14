#
# Author: Vidal Graupera
#
# Example REST source adapter using http://lighthouseapp.com/api/tickets
#
# Gets changes and comments for a ticket
#
# Calls - GET /projects/#{project_id}/tickets/#{number}.xml
# This fetches not only the latest version of the ticket, but all of the previous versions.
# We already got the current attributes of the ticket in LighthouseTickets. This code is to get
# the versions which includes the changes and comments

class LighthouseTicketVersions < SourceAdapter
  
  include RestAPIHelpers
  include ActiveSupport::Inflector
  
  def initialize(source)
    super
  end

  def query
    log "LighthouseTicketVersions query"
    @result = []
    
    # iterate over all tickets and get the versions for each
    lighthouseTickets = Source.find_by_adapter("LighthouseTickets")
    tickets = ObjectValue.find(:all, :conditions => ["source_id = ? and update_type = 'query' and attrib = 'title'", 
      lighthouseTickets.id])
          
    tickets.each do |ticket|  
      uri = URI.parse(@source.url)
      project, number = split_id(ticket.object)    
      req = Net::HTTP::Get.new("/projects/#{project}/tickets/#{number}.xml", 'Accept' => 'application/xml')
      req.basic_auth @source.credential.token, "x"
      response = Net::HTTP.start(uri.host,uri.port) do |http|
        http.request(req)
      end
      xml_data = XmlSimple.xml_in(response.body); 
      
      # versions is an array of version hashes
      if xml_data["versions"] && xml_data["versions"][0] && xml_data["versions"][0]["version"]
        @result = @result + xml_data["versions"][0]["version"]
      end
    end
  end

  def sync
    log "LighthouseTicketVersions sync, with #{@result.length} results"
    
    @result.each do |version|
      # construct unique ID for ticket versions, tickets are identified by project-id/number in lighthouse
      # and number itself is not unique, here we also append the timestamp since there willl always be more 
      # than 1 version for same project_id-number
      id = "#{version['project-id'][0]['content']}-#{version['number'][0]['content']}-#{version['updated-at'][0]['content']}"
      
      # here we just want to know who made the change and when, other fields we dont save to DB
      %w(updated-at user-id).each do |key|
        value = version[key] ? version[key][0] : ""
        add_triple(@source.id, id, key.gsub('-','_'), value)
        # convert "-" to "_" because "-" is not valid in ruby variable names   
      end    
      
      # process the "diffable-attributes"
      changes = YAML::load(version['diffable-attributes'][0]['content'])
      # log changes.inspect.to_s
      
      # this is temporary. we prepare the HTML here for the changes, really should be made on the client
      if changes && changes.length > 0
        # prepare change message
        events = []
        changes.each_pair do |field,value|
          if !value
            events << "#{humanize(field)} cleared."
          else
            key = case field
            when :milestone:
              "milestone-id"
            when :assigned_user:
              "assigned-user-id"
            else
              field.to_s
            end
      
            events << "#{humanize(field)} changed from \"#{eval_value(version[key][0])}\" to \"#{value}\""
          end
        end
        change_msg = events.join("||||") # assume no ticket contains this in the body
      else
        # if there are no changes then that means there was a comment which is in body
        change_msg = version['body'][0] 
      end
            
      add_triple(@source.id, id, "changes", change_msg)
      add_triple(@source.id, id, "ticket_id", "#{version['project-id'][0]['content']}-#{version['number'][0]['content']}")    
    end
  end
  
end