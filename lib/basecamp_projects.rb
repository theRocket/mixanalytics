class BasecampProjects 
  attr_accessor :client
  
  include RestAPIHelpers

  def login
    # intentionally left blank
  end

  def query
    uri = URI.parse(@source.url+"/projects.xml")
    req = Net::HTTP::Get.new(uri.path, 'Accept' => 'application/xml')
    req.basic_auth @source.login, @source.password
    response = Net::HTTP.start(uri.host,uri.port) do |http|
      http.request(req)
    end
    xml_data = XmlSimple.xml_in(response.body); 
    @result = xml_data["project"]
  end

  def sync
    @result.each do |project|
      id = project["id"][0]["content"]      
    
      %w(name status).each do |key|
        add_triple(@source.id, id, key, project[key][0], @source.current_user.id)      
      end
      
      add_triple(@source.id, id, "company_id", project["company"][0]["id"][0]["content"], @source.current_user.id)
    end
  end

  def create(name_value_list)
  end

  def update(name_value_list)
  end

  def delete(name_value_list)
  end

  def logoff
    # intentionally left blank
  end

end