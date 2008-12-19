class SugarAccounts < SourceAdapter

  def initialize(source)
    super(source)
  end

  def login
    u = @source.login
    p = Digest::MD5.hexdigest(@source.password)
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
    module_name = 'Accounts'
    query = '' # gets all the acounts, you can also use SQL like 'accounts.name like '%company%''
    order_by = '' # in default order. you can also use SQL like 'accounts.name'
    offset = 0
    select_fields = ['name','industry'] # this can't be an empty array
    max_results = '10000' # if set to 0 or '', this doesn't return all the results
    deleted = 0 # whether you want to retrieve deleted records, too
    @result = client.get_entry_list(@session_id,module_name,query,order_by,offset,select_fields,max_results,deleted);
  end

  def sync
    @result.entry_list.each do |x|
      x.name_value_list.each do |y|
        o=ObjectValue.new
        o.source_id=@source.id
        o.object=x['id']
        o.attrib=y.name
        o.value=y.value
        o.save
      end
    end
  end

  def create(name_value_list)
    result=@client.set_entry(@session_id,'Accounts',name_value_list)
  end

  def update(name_value_list)
    result=@client.set_entry(@session_id,'Accounts',name_value_list)
  end

  def delete(name_value_list)
    name_value_list.push({'name'=>'deleted','value'=>'1'});
    result=@client.set_entry(@session_id,'Accounts',name_value_list)
  end

  def logoff
    @client.logout(@session_id)
  end
end