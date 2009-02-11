require 'soap/wsdlDriver'

class SugarAdapter < SourceAdapter

  attr_accessor :module_name
  attr_accessor :order_by
  attr_accessor :select_fields 
  attr_accessor :query_filter
    
  attr_accessor :client
  
  def initialize(source,credential)
    puts "SugarCRM initialize with #{source.inspect.to_s}"
    
    super(source,credential)
    
    @select_fields = [] # leave empty like this to get all fields
    @order_by = ''
    @query_filter = '' # you can also use SQL like 'accounts.name like '%company%''
    
    url = (credential and !credential.url.blank?) ? credential.url : source.url
    p "Creating adapter for "+ url
    begin
      @client = SOAP::WSDLDriverFactory.new(url).create_rpc_driver
    rescue RuntimeError => e
      logger.info "Failed to create WSDL driver: " + e.to_s
    end
    @client.options['protocol.http.receive_timeout'] = 3600 
  end

  def login
    puts "SugarCRM #{@module_name} login"
    if @source.credential
      u = @source.credential.login
      p = Digest::MD5.hexdigest(@source.credential.password)
    else
      u = @source.login
      p = Digest::MD5.hexdigest(@source.password)
    end
  
    ua = {'user_name' => u,'password' => p}
    ss = @client.login(ua,nil)
    if ss.error.number.to_i != 0
      p 'failed to login - #{ss.error.description}'
      return
    else
      @session_id = ss['id']
      uid = @client.get_user_id(@session_id)
    end
  end

  def query
    puts "SugarCRM #{@module_name} query"
    
    offset = 0
    max_results = '10000' # if set to 0 or '', this doesn't return all the results
    deleted = 0 # whether you want to retrieve deleted records, too
  
    # puts "============\n"
    # @client.get_module_fields(@session_id,@module_name).module_fields.each do |field|
    #   puts field.name
    # end
    # puts "============\n"
  
    @count = @client.get_entries_count(@session_id,@module_name,@query_filter,deleted).result_count
    puts "@count =#{@count}"
    
    @result = @client.get_entry_list(@session_id,@module_name,@query_filter,@order_by,offset,@select_fields,max_results,deleted);
  end

  def sync
    puts "SugarCRM #{@module_name} sync with #{@result.entry_list.length}"
        
    # TODO: cannot have fields named "type" or other reserved ruby keywords either for that matter
    user_id=@source.current_user.id
    @result.entry_list.each do |x|      
      x.name_value_list.each do |y|
        unless y.value.blank?
          o=ObjectValue.new
          o.source_id=@source.id
          o.object=x['id']
          o.attrib=y.name
          o.value=y.value
          o.user_id=user_id if @source.credential
          o.save
        end
      end
    end
  end

  def create(name_value_list)
    puts "SugarCRM #{@module_name} create #{name_value_list.inspect.to_s}"
    
    result=@client.set_entry(@session_id,@module_name,name_value_list)
  end

  def update(name_value_list)
    puts "SugarCRM #{@module_name} update #{name_value_list.inspect.to_s}"
    
    result=@client.set_entry(@session_id,@module_name,name_value_list)
  end

  def delete(name_value_list)
    puts "SugarCRM #{@module_name} delete #{name_value_list.inspect.to_s}"
    
    name_value_list.push({'name'=>'deleted','value'=>'1'});
    result=@client.set_entry(@session_id,@module_name,name_value_list)
  end

  def logoff
    @client.logout(@session_id)
  end
  
  def set_callback(notify_url)
  end
end