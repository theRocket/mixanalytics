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
    @result.each do |ticket|
      user_id = ticket["assigned-user-id"][0]["content"]
      # right now we just filter for this user in the adapater   
      
      if (user_id.to_i == 9435)
        id = ticket["number"][0]["content"]      
        
        %w(closed created-at creator-id milestone-id priority state tag title updated-at project-id).each do |key|
          add_triple(@source.id, id, key.gsub('-','_'), ticket[key][0])
          # convert "-" to "_" because "-" is not valid in ruby variable names    
        end
      end
      
    end
  end

# Example of how you would test this API on the command line
#   curl -u "<API key>:x" -d "<ticket><title>new ticket</title></ticket>" -H 'Accept: application/xml' 
#   -H 'Content-Type: application/xml' http://<account>.lighthouseapp.com/projects/<project-id>/tickets.xml

  def create(name_value_list)
    # name_value_list example, "[{'name' => 'title', 'value' => 'testing'},{'name' => 'state', 'value' => 'new'}]"
    
    params = {}
    name_value_list.each do |pair| 
      params.merge!(Hash[pair['name'], pair['value']])
    end
    # puts params.inspect

    # construct and fill in XML template
    xml_str  = <<-EOT
    <ticket>
      <assigned-user-id type="integer">9435</assigned-user-id>
      <body>#{params['body']}</body>
      <milestone-id type="integer"></milestone-id>
      <state>#{params['state']}</state>
      <title>#{params['title']}</title>
    </ticket>
    EOT
    
    puts xml_str
    
    uri = URI.parse(@source.url)
    Net::HTTP.start(uri.host) do |http|
      # http.set_debug_output $stderr
      request = Net::HTTP::Post.new(uri.path + "/tickets.xml", {'Content-type' => 'application/xml'})
      request.body = xml_str
      request.basic_auth @source.login, @source.password
      response = http.request(request)
      puts response.body
      
      # case response
      # when Net::HTTPSuccess, Net::HTTPRedirection
      #   # OK
      # else
      #   raise "Failed to create  ticket"
      # end
    end
  end

  def update(name_value_list)
    #TODO: write some code here
  end

  def delete(name_value_list)
    #TODO: write some code here if applicable
  end

  def logoff
    #left intentionally blank, not used in REST
  end
  
  protected
  
  def add_triple(source_id, object_id, attrib, value)
    puts "#{source_id}, #{object_id}, #{attrib}, #{value}\n"
    o=ObjectValue.new
    o.source_id=source_id
    o.object=object_id
    o.attrib=attrib
    
    # handle value = {"nil"=>"true"}
    if (value.class == String)
      o.value= value
    else
      o.value= nil
    end
      
    if !o.save
      puts "failed creating triple #{source_id}, #{object_id}, #{attrib}, #{value}"
    end
  end
end