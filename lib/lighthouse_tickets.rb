#
# Author: Vidal Graupera
#
# Example REST source adapter using http://lighthouseapp.com/api/tickets
#
# there is an official Ruby Library for interacting with the Lighthouse API
# however we do not use it in this example in order to show how to do basic REST operations
# with plain Net:HTTP and Rhosync
#
# EXAMPLE XML for a ticket
# <ticket>
#   <assigned-user-id type="integer">9435</assigned-user-id>
#   <attachments-count type="integer">0</attachments-count>
#   <closed type="boolean">false</closed>
#   <created-at type="datetime">2008-12-19T11:00:16-08:00</created-at>
#   <creator-id type="integer">9435</creator-id>
#   <milestone-id type="integer">26804</milestone-id>
#   <number type="integer">1</number>
#   <permalink>show-tickets</permalink>
#   <priority type="integer">1</priority>
#   <project-id type="integer">22198</project-id>
#   <state>new</state>
#   <tag nil="true"></tag>
#   <title>Show tickets</title>
#   <updated-at type="datetime">2008-12-19T11:00:56-08:00</updated-at>
#   <user-id type="integer">9435</user-id>
# </ticket>

class LighthouseTickets < SourceAdapter
    
  def initialize(source)
    super
  end

  def login
    #left intentionally blank, as we authenticate as part of each request
  end

  def query
    log "LighthouseTickets query"
    
    # this query will get all tickets for a given project which is specified in the URL for this source
    # example, http://<account>.lighthouseapp.com/projects/<project-id>
    # a later improvement would iterate over all projects for a user and get the tickets for each
    
    uri = URI.parse(@source.url+"/tickets.xml")
    req = Net::HTTP::Get.new(uri.path, 'Accept' => 'application/xml')
    req.basic_auth @source.login, @source.password
    response = Net::HTTP.start(uri.host,uri.port) do |http|
      http.request(req)
    end
    xml_data = XmlSimple.xml_in(response.body); 
    @result = xml_data["ticket"]
  end

  def sync
    log "LighthouseTickets sync"
    
    @result.each do |ticket|
      user_id = ticket["assigned-user-id"][0]["content"]
      # right now we just filter for this user in the adapater   
      
      #TODO: @source.current_user.login
      if (user_id.to_i == 9435)
        id = ticket["number"][0]["content"]      
        
        # iterate over all possible values, if the value is not found we just pass "" in to rhosync
        %w(body closed created-at creator-id milestone-id priority state tag title updated-at project-id).each do |key|
          value = ticket[key] ? ticket[key][0] : ""
          add_triple(@source.id, id, key.gsub('-','_'), value)
          # convert "-" to "_" because "-" is not valid in ruby variable names   
        end
      end
      
    end
  end

# Example of how you would test this API on the command line
#   curl -u "<API key>:x" -d "<ticket><title>new ticket</title></ticket>" -H 'Accept: application/xml' 
#   -H 'Content-Type: application/xml' http://<account>.lighthouseapp.com/projects/<project-id>/tickets.xml

  def create(name_value_list)
    log "LighthouseTickets create"
    
    get_params(name_value_list)
    xml_str = xml_template(params)
    
    uri = URI.parse(@source.url)
    Net::HTTP.start(uri.host) do |http|
      http.set_debug_output $stderr
      request = Net::HTTP::Post.new(uri.path + "/tickets.xml", {'Content-type' => 'application/xml'})
      request.body = xml_str
      request.basic_auth @source.login, @source.password
      response = http.request(request)
      log response.body
      
      # case response
      # when Net::HTTPSuccess, Net::HTTPRedirection
      #   # OK
      # else
      #   raise "Failed to create  ticket"
      # end
    end
  end

  def update(name_value_list)
    log "LighthouseTickets update"
    
    get_params(name_value_list)
    
    # we are only passed the attributes that changed. we need to fill in all the others from the DB
    %w(body closed creator-id milestone-id priority state tag title project-id).each do |key|
      searchkey = key.gsub('-','_')
      unless params[searchkey]
        o=ObjectValue.find(:first, :conditions => ["source_id = ? and object = ? and attrib = ?", 
          @source.id, params['id'], searchkey])
        params.merge!(key => o.value) if o
      end  
    end

    xml_str = xml_template(params)

    uri = URI.parse(@source.url)
    Net::HTTP.start(uri.host) do |http|
      http.set_debug_output $stderr
      request = Net::HTTP::Put.new(uri.path + "/tickets/#{params['id']}.xml", {'Content-type' => 'application/xml'})
      request.body = xml_str
      request.basic_auth @source.login, @source.password
      response = http.request(request)
      log response.body

      # case response
      # when Net::HTTPSuccess, Net::HTTPRedirection
      #   # OK
      # else
      #   raise "Failed to create  ticket"
      # end
    end
  end

  def delete(name_value_list)
    log "LighthouseTickets delete"
    
    get_params(name_value_list)
    
    uri = URI.parse(@source.url)
    Net::HTTP.start(uri.host) do |http|
     http.set_debug_output $stderr
     request = Net::HTTP::Delete.new(uri.path + "/tickets/#{params['id']}.xml", {'Content-type' => 'application/xml'})
     request.basic_auth @source.login, @source.password
     response = http.request(request)
     log response.body

     # case response
     # when Net::HTTPSuccess, Net::HTTPRedirection
     #   # OK
     # else
     #   raise "Failed to create  ticket"
     # end
    end
  end

  def logoff
    #left intentionally blank, not used in REST
  end
  
  protected
  
  def log(msg)
    puts msg
  end
  
  # convert name_value_list to a params hash
  # name_value_list example, "[{'name' => 'title', 'value' => 'testing'},{'name' => 'state', 'value' => 'new'}]"
  # => params['title'] = 'testing', etc.
  def get_params(name_value_list)
    @params = {}
    name_value_list.each do |pair| 
      @params.merge!(Hash[pair['name'], pair['value']])
    end
    log @params.inspect
  end
  
  def params
    @params
  end
  
  # construct and fill in XML template for lighthouse xml API
  def xml_template(params)
    xml_str  = <<-EOT
    <ticket>
      <assigned-user-id type="integer">9435</assigned-user-id>
      <body>#{params['body']}</body>
      <milestone-id type="integer">#{params['milestone_id']}</milestone-id>
      <state>#{params['state']}</state>
      <closed type="boolean">#{params['closed']}</closed>
      <title>#{params['title']}</title>
      <priority type="integer">#{params['priority']}</priority>
      <tag>#{params['tag']}</tag>
    </ticket>
    EOT
    
    log xml_str
    xml_str
  end
  
  # make an ObjectValue triple for rhosync
  def add_triple(source_id, object_id, attrib, value)
    o = ObjectValue.new
    o.source_id=source_id
    o.object=object_id
    o.attrib=attrib
        
    # all values are strings
    if value.class == String
      o.value = value
    elsif value.class == Hash
      if value["nil"] && value["nil"] == "true"
        o.value = ""
      else
        o.value = value["content"].to_s
      end
    end
    
    # values cannot contain double quotes, convert to single
    # there might be other characters as well that need escaping TBD
    o.value.gsub!(/\"/, "\'")
          
    if !o.save
      log "failed creating triple"
    end
    
    log "Add ObjectValue: #{source_id}, #{object_id}, #{attrib}, #{value.inspect} => \n #{o.inspect}\n"
  end
end