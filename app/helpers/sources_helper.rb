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


  # creates an object_value list for a given client
  # based on that client's client_map records
  # and the current state of the object_values table
  # since we do a delete_all in rhosync refresh, 
  # only delete and insert are required
  def process_objects_for_client(client_id, source_id)
    
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
    
    # look for changes in the current object_values list
    @object_values = ObjectValue.find_all_by_source_id_and_update_type(source_id, 'query')
    objs_to_return = []
    if @object_values
      
      # find the new records
      @object_values.each do |ov|
        #logger.debug "current object_value: #{ov.inspect}"
        map = ClientMap.find_or_initialize_by_client_id_and_object_value_id({:client_id => client_id, 
                                                                             :object_value_id => ov.id,
                                                                             :object_value_object => ov.object,
                                                                             :object_value_attrib => ov.attrib,
                                                                             :object_value_value => ov.value,
                                                                             :db_operation => 'insert'})
        #logger.debug "client_map record: #{map.inspect}"                                                                     
        if map and map.new_record?
          map.save
          map.object_value.db_operation = map.db_operation
          objs_to_return << map.object_value
        end
      end
    end
    
    # delete records that don't exist in the cache table anymore
    maps_to_delete = ClientMap.find_all_by_client_id(client_id)
    maps_to_delete.each do |map|
      obj = map.object_value
      if obj.nil?
        temp_obj = ObjectValue.new
        temp_obj.object = map.object_value_object
        temp_obj.db_operation = 'delete'
        temp_obj.created_at = temp_obj.updated_at = Time.now.to_s
        temp_obj.attrib = map.object_value_attrib
        temp_obj.value = map.object_value_value
        temp_obj.update_type = "delete"
        temp_obj.id = 0
        temp_obj.source_id = 0
        logger.debug "Removing object: #{temp_obj.inspect} from map table and client"
        objs_to_return << temp_obj
        # remove from map table
        ClientMap.delete_all(:client_id => map.client_id, 
                             :object_value_object => map.object_value_object,
                             :object_value_attrib => map.object_value_attrib,
                             :object_value_value => map.object_value_value)
      end
    end
    objs_to_return
  end
end