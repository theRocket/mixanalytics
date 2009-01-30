# API documentation http://developer.37signals.com/basecamp/companies.shtml

class BasecampCompanies 
  attr_accessor :client
  
  include RestAPIHelpers

  def login
    # intentionally left blank
  end

  def query
    puts @source.inspect
    uri = URI.parse(@source.url+"/companies.xml")
    req = Net::HTTP::Get.new(uri.path, 'Accept' => 'application/xml')
    req.basic_auth @source.login, @source.password
    response = Net::HTTP.start(uri.host,uri.port) do |http|
      http.request(req)
    end
    xml_data = XmlSimple.xml_in(response.body); 
    @result = xml_data["company"]
  end

  def sync
    @result.each do |company|
      id = company["id"][0]["content"]    
      
      %w(name city zip phone-number-office address-one address-two country web-address uuid 
        phone-number-fax url-name time-zone-id state).each do |key|
          add_triple(@source.id, id, key.gsub('-','_'), company[key][0], @source.current_user.id)      
      end
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