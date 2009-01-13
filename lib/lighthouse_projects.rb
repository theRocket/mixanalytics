#
# Author: Vidal Graupera
#
# Example REST source adapter using http://lighthouseapp.com/api/projects
#
# <project>
#   <archived type="boolean">false</archived>
#   <created-at type="datetime">2008-09-25T20:04:13+01:00</created-at>
#   <default-assigned-user-id type="integer" nil="true"/>
#   <default-milestone-id type="integer" nil="true"/>
#   <description nil="true"/>
#   <description-html/>
#   <id type="integer">17456</id>
#   <license>mit</license>
#   <name>oss with license</name>
#   <open-projects-count type="integer">0</open-projects-count>
#   <permalink>oss-with-license</permalink>
#   <public type="boolean">true</public>
#   <updated-at type="datetime">2008-09-25T20:04:14+01:00</updated-at>
#   <open-states>
#     new/f17  # You can add comments here
#     open/aaa # if you want to.
#   </open-states>
#   <closed-states>
#     resolved/6A0 # You can customize colors
#     hold/EB0     # with 3 or 6 character hex codes
#     invalid/A30  # 'A30' expands to 'AA3300'
#   </closed-states>
#   <open-states-list>new,open</open-states-list>
#   <closed-states-list>resolved,hold,invalid</closed-states-list>
# </project>

class LighthouseProjects < SourceAdapter
  
  include RestAPIHelpers
  
  def initialize(source)
    super
  end

  def query
    log "LighthouseProjects query"
    
    uri = URI.parse(@source.url+"/projects.xml")
    req = Net::HTTP::Get.new(uri.path, 'Accept' => 'application/xml')
    req.basic_auth @source.credential.token, "x"
    
    response = Net::HTTP.start(uri.host,uri.port) do |http|
      http.request(req)
    end
    xml_data = XmlSimple.xml_in(response.body); 
    @result = xml_data["project"]
  end

  def sync
    log "LighthouseProjects sync, with #{@result.length} results"
    
    @result.each do |project|
      id = project["id"][0]["content"]
      
      # iterate over all possible values, if the value is not found we just pass "" in to rhosync
      %w(created-at default-assigned-user-id default-milestone-id description name public updated-at open-states-list closed-states-list).each do |key|
        value = project[key] ? project[key][0] : ""
        add_triple(@source.id, id, key.gsub('-','_'), value)
        # convert "-" to "_" because "-" is not valid in ruby variable names   
      end
    end
  end
  
  # not planning to create, update or delete projects on device
end