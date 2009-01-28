module SourcesHelper

  # determines if the logged in users is a subscriber of the current app or 
  # admin of the current app
  def check_access(app)
    matches_login=app.users.select{ |u| u.login==current_user.login}
    matches_login << app.admin if app.admin==current_user.login  # let the administrator of the app in as well
    if matches_login.nil? or matches_login.size == 0
      p "User: " + current_user.login + " not allowed access."
      response.redirect  :action=>"noaccess",:login=>current_user.login
    end
    p "User: " + current_user.login + " permitted access."
  end
  
  def needs_refresh
    result=nil
    # refresh if there are any updates to come
    result=true if (ObjectValue.count_by_sql "select count(*) from object_values where update_type!='query' and source_id="+id.to_s) > 0
    # refresh if there is no data
    result=true if (ObjectValue.count_by_sql "select count(*) from object_values where update_type='query' and source_id="+id.to_s) <= 0
    # refresh is the data is old
    self.pollinterval||=300 # 5 minute default if there's no pollinterval or its a bad value
    if !self.refreshtime or ((Time.new - self.refreshtime)>pollinterval)
      result=true
    end
    result  # return true of false (nil)
  end
  
  def clear_pending_records(current_user)
    delete_cmd= "(update_type='pending') and source_id="+id.to_s
    (delete_cmd << " and user_id="+ current_user.id.to_s) if current_user # if there is a credential then just do delete and update based upon the records with that credential
    ObjectValue.delete_all delete_cmd
  end

  def finalize_query_records(current_user)
    delete_cmd= "(update_type='query') and source_id="+id.to_s
    (delete_cmd << " and user_id="+ current_user.id.to_s) if current_user # if there is a credential then just do delete and update based upon the records with that credential
    ObjectValue.delete_all delete_cmd
    pending_to_query="update object_values set update_type='query',id=pending_id where (update_type='pending' or update_type is null) and source_id="+id.to_s
    (pending_to_query << " and user_id=" + current_user.id.to_s) if current_user 
    ActiveRecord::Base.connection.execute(pending_to_query)
    self.refreshtime=Time.new # timestamp    
  end

  # helper function to come up with the string used for the name_value_list
  # name_value_list =  [ { "name" => "name", "value" => "rhomobile" },
  #                     { "name" => "industry", "value" => "software" } ]
  def make_name_value_list(hash)
    if hash and hash.keys.size>0
      result="["
      hash.keys.each do |x|
        result << ("{'name' => '"+ x +"', 'value' => '" + hash[x] + "'},") if x and x.size>0 and hash[x]
      end
      result=result[0...result.size-1]  # chop off last comma
      result += "]"
    end
  end
    
  def process_update_type(utype,utypecall)
    objs=ObjectValue.find_by_sql("select distinct(object) from object_values where update_type='"+ utype +"'and source_id="+id.to_s)
    objs.each do |x|
      objvals=ObjectValue.find_all_by_object_and_update_type(x.object,utype)  # this has all the attribute value pairs now
      attrvalues={}
      attrvalues["id"]=x.object if utype!='create' # setting the ID allows it be an update or delete
      objvals.each do |y|
        attrvalues[y.attrib]=y.value
        y.destroy
      end
      # now attrvalues has the attribute values needed for the createcall
      nvlist=make_name_value_list(attrvalues)
      if source_adapter
        name_value_list=eval(nvlist)
        eval("source_adapter." +utype +"(name_value_list)")
      else
        (raise ArgumentError,"Need some code to execute for " + utype) if utypecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+utypecall+";binding",callbinding)
      end
    end
  end

  # creates an object_value list for a given client
  # based on that client's client_map records
  # and the current state of the object_values table
  # since we do a delete_all in rhosync refresh, 
  # only delete and insert are required
  def process_objects_for_client(source,client_id)
    
    # setup client & user association if it doesn't exist
    if client_id and client_id != 'client_id'
      @client = Client.find_by_client_id(client_id)
      if @client.nil?
        @client = Client.new
        @client.client_id = client_id
      end
      @client.user ||= current_user
      @client.save
    end
    
    # look for changes in the current object_values list, return only records
    # for the current user if required
    if current_user
      @object_values = ObjectValue.find_all_by_source_id_and_update_type_and_user_id(source.id, 'query', current_user.id)
    end
    objs_to_return = []
    
    # VERY IMPORTANT - delete records that don't exist in the cache table anymore
    # We MUST do this before the insert loop below to avoid ID collisions
    maps_to_delete = ClientMap.find_all_by_client_id(client_id)
    maps_to_delete.each do |map|
      obj = map.object_value
      if obj.nil? or obj.value != map.object_value_value
        objs_to_return << new_delete_obj(map.object_value_object,
                                         map.object_value_attrib,
                                         map.object_value_value)
        ClientMap.delete_all(:client_id => map.client_id,
                             :object_value_object => map.object_value_object,
                             :object_value_attrib => map.object_value_attrib,
                             :object_value_value => map.object_value_value)
      end
    end
    
    if @object_values
      # find the new records
      @object_values.each do |ov|
        map = ClientMap.find_or_initialize_by_client_id_and_object_value_id_and_object_value_object_and_object_value_attrib_and_object_value_value(
                        {:client_id => client_id, 
                         :object_value_id => ov.id,
                         :object_value_object => ov.object,
                         :object_value_attrib => ov.attrib,
                         :object_value_value => ov.value,
                         :db_operation => 'insert'})             
                                                                              
        if map and map.new_record?
          map.object_value.db_operation = map.db_operation
          objs_to_return << map.object_value
          map.save
        end
      end
    end
    # Update the last updated time for this client
    @client.update_attribute(:updated_at, Time.now)
    objs_to_return
  end
  
  def new_delete_obj(object,attrib,value)
    temp_obj = ObjectValue.new
    temp_obj.object = object
    temp_obj.db_operation = 'delete'
    temp_obj.created_at = temp_obj.updated_at = Time.now.to_s
    temp_obj.attrib = attrib
    temp_obj.value = value
    temp_obj.update_type = "delete"
    temp_obj.id = 0
    temp_obj.source_id = 0
    temp_obj
  end
  
  # useful to be able to have the source adapter code available for viewing in YAML files
  def save_to_yaml
    File.open(name+'.yml','w') do |out|
      out.puts to_yaml
    end
  end
end