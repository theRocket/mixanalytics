require 'siebel/defaultDriver.rb'

class SiebelServiceRequests < SourceAdapter
  
  attr_accessor :obj
  
  def login
    puts "SiebelServiceRequests login source = #{@source.inspect.to_s}"
    
    https = Net::HTTP.new(@source.url,443)
    https.set_debug_output $stderr
    
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
    endpoint_url ="https://#{@source.url}/Services/Integration/ServiceRequest;jsessionid=#{session}"
    puts "endpt = #{endpoint_url}"
    
    @obj = Default_Binding_ServiceRequest.new(endpoint_url)
    @obj.wiredump_dev = STDERR
  end

  def query
    puts "SiebelServiceRequests query with obj= #{@obj}"
    return if @obj.nil?

    begin
      input=ServiceRequestWS_ServiceRequestQueryPage_Input.new
      # input.StartRowNum=0
      # input.PageSize=10
      s=ServiceRequest.new
      s.LastUpdated=">= 01/01/2009 00:00:00"
      s.ServiceRequestId=""
      # s.Subject=""
      # s.CreatedDate=""
      # s.AccountName=""
      # s.Description=""
      # s.Priority=""
      input.ListOfServiceRequest=[s]
      @result=@obj.serviceRequestQueryPage(input)
      puts "returning from query"
      puts @result.inspect.to_s
    rescue => e
      puts "exception #{e.inspect}"
    end
  end

  def sync
    puts "SiebelServiceRequests sync with #{@result.inspect.to_s}"

    if @result
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
  end

  def create(name_value_list)
    puts "SiebelServiceRequests create #{name_value_list.inspect.to_s}"
    
    input=ServiceRequestWS_ServiceRequestInsert_Input.new
    s=ServiceRequest.new
    s.serviceRequestId=""
    s.accountName=name_value_list[0]["value"] # account name
    s.description=name_value_list[1]["value"] # description
    s.priority=name_value_list[2]["value"] # priority
    s.subject=name_value_list[3]["value"] # subject
    input.listOfServiceRequest=[s]
    result=@obj.serviceRequestInsert(input)
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
    output=@obj.serviceRequestUpdate(input)
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