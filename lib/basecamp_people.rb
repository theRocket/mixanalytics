# documentation for this REST API at http://developer.37signals.com/basecamp/people.shtml

class BasecampPeople 
  attr_accessor :client
  
  include RestAPIHelpers

  def login
    #left intentionally blank
  end

  def query
  end

  def sync
    # we iterate over the Basecammp Companies
    if companies = Source.find_by_name("BasecampCompanies") # get the ID of that source adpater on this system
      ObjectValue.find(:all, :conditions => ["source_id = ? and attrib = 'name'", companies.id]).each do |company|
        uri = URI.parse(@source.url+"/contacts/people/#{company.object}")
        req = Net::HTTP::Get.new(uri.path, 'Accept' => 'application/xml')
        req.basic_auth @source.login, @source.password
        response = Net::HTTP.start(uri.host,uri.port) do |http|
          http.request(req)
        end
    
        xml_data = XmlSimple.xml_in(response.body); 
        @people_data = xml_data["person"]
        get_all_people(@people_data)
        
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
    #left intentionally blank
  end
  
  protected
  
  def get_all_people(people)
    people.each do |person|
      id = person['id'][0]['content']
          
      %w(first-name last-name email-address).each do |key|
          add_triple(@source.id, id, key.gsub('-','_'), person[key][0], @source.current_user.id)      
      end
    end
  end
end