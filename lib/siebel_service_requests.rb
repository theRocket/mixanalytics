require 'siebel/defaultDriver.rb'

class SiebelServiceRequests < SourceAdapter
  
  attr_accessor :obj
  
  def login
    puts "SiebelServiceRequests login source = #{@source.inspect.to_s}"
    
    # always log into this url https://secure.crmondemand.com/Services/Integration?command=login
    https = Net::HTTP.new("secure.crmondemand.com",443)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    if @source.credential
      u = @source.credential.login
      p = @source.credential.password
    else
      u = @source.login
      p = @source.password
    end
      
    headers={"UserName"=>u,"Password"=>p}
    @session_id=nil
    https.start do |https|
      req = Net::HTTP::Get.new("/Services/Integration?command=login", headers)
      response = https.request(req)
      resp = response.body
      p "Response " + resp
      @session_id=response['Set-Cookie']
    end
    session=@session_id.to_s
    start=session.index('=')
    finish=session.index(';')
    session=session[start+1...finish] if start and finish
    endpoint_url ='https://secure-ausomxbha.crmondemand.com/Services/Integration/ServiceRequest;jsessionid='+session
    
    obj = Default_Binding_ServiceRequest.new(endpoint_url)
    obj.wiredump_dev = STDERR
    http=nil
  end

  def query
    puts "SiebelServiceRequests query"
    if obj.nil?
      puts "obj nil" and return
    end
    
    input=ServiceRequestWS_ServiceRequestQueryPage_Input.new
    input.startRowNum=0
    s=ServiceRequest.new
    s.serviceRequestId=""
    s.subject=""
    s.createdDate=""
    s.accountName=""
    s.description=""
    s.priority=""
    input.listOfServiceRequest=[s]
    @result=obj.serviceRequestQueryPage(input)
  end

  def sync
    puts "SiebelServiceRequests sync with #{@result.listOfServiceRequest.length}"

    @result.listOfServiceRequest.each do |x|
      # subject
      o=ObjectValue.new
      o.source_id=@source.id
      o.object=x.serviceRequestId
      o.attrib="subject"
      o.value=x.subject
      o.save
      #accountName
      o=ObjectValue.new
      o.source_id=@source.id
      o.object=x.serviceRequestId
      o.attrib="accountName"
      o.value=x.accountName
      o.save
      #description
      o=ObjectValue.new
      o.source_id=@source.id
      o.object=x.serviceRequestId
      o.attrib="description"
      o.value=x.description
      o.save
      #priority
      o=ObjectValue.new
      o.source_id=@source.id
      o.object=x.serviceRequestId
      o.attrib="priority"
      o.value=x.priority
      o.save
      #createdDate attribute
      o=ObjectValue.new
      o.source_id=@source.id
      o.object=x.serviceRequestId
      o.attrib="createdDate"
      o.value=x.createdDate
      o.save
    end
  end

  def create(name_value_list)
    puts "SiebelServiceRequests create #{name_value_list.inspect.to_s}"
    
    ServiceRequestWS_ServiceRequestInsert_Input.new
    s=ServiceRequest.new
    s.serviceRequestId=""
    s.accountName=name_value_list[0]["value"] # account name
    s.description=name_value_list[1]["value"] # description
    s.priority=name_value_list[2]["value"] # priority
    s.subject=name_value_list[3]["value"] # subject
    input.listOfServiceRequest=[s]
    result=obj.serviceRequestInsert(input)
  end

  def update(name_value_list)
    puts "SiebelServiceRequests update #{name_value_list.inspect.to_s}"
    
    input=ServiceRequestWS_ServiceRequestUpdate_Input.new
    s=ServiceRequest.new
    s.accountName=name_value_list[0]["value"] # account name
    s.description=name_value_list[1]["value"] # description
    s.priority=name_value_list[2]["value"] # priority
    s.serviceRequestId=name_value_list[3]["value"] # subject
    input.listOfServiceRequest=[s]
    output=obj.serviceRequestUpdate(input)
  end

  def delete(name_value_list)
    puts "SiebelServiceRequests delete #{name_value_list.inspect.to_s}"
    
    input=ServiceRequestWS_ServiceRequestDelete_Input.new
    s=ServiceRequest.new
    s.serviceRequestId=name_value_list[0]["value"] # ID
    input.listOfServiceRequest=[s]
    output=obj.serviceRequestDelete(input)
  end

  def logoff
    # https://secure.crmondemand.com/Services/Integration?command=logoff;
  end
  
  def set_callback(notify_urL)
  end
  
end