class LighthouseProjects < SourceAdapter
  
  def initialize(source)
    super
  end

  def login
    #TODO: Write some code here
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
    # usually the generic base class sync does the job
    super
  end

  def create(name_value_list)
    #TODO: write some code here
  end

  def update(name_value_list)
    #TODO: write some code here
  end

  def delete(name_value_list)
    #TODO: write some code here if applicable
  end

  def logoff
    #TODO: write some code here if applicable
  end
end