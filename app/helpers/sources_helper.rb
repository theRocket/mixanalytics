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

  def do_refresh(id)
    @source=Source.find id
    @source.current_user=@current_user
    @source.initadapter
    # not all endpoints require WSDL! dont do this if you dont see WSDL in the URL (a bit of a hack)
    client = SOAP::WSDLDriverFactory.new(@source.url).create_rpc_driver if @source.url and @source.url.size>0 and @source.url=~/wsdl/
    @source.source_adapter.client=client if @source.source_adapter
    # make sure to use @client and @session_id variables
    # in your code that is edited into each source!
    if @source.source_adapter
      @source.source_adapter.login
    else
      callbinding=eval %"#{@source.prolog};binding"
    end
    # also you can get user credentials from @source.credential
    usersub=@source.app.memberships.find_by_user_id(@current_user.id)
    @source.credential=usersub.credential if usersub # this variable is available in your source adapter

    # first do all the the creates
    creates=ObjectValue.find_by_sql("select * from object_values where update_type='create' and source_id="+id)
    uniqobjs=creates.map {|x| x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      xvals=ObjectValue.find_all_by_object_and_update_type(x,'create')  # this has all the attribute value pairs for this particular object
      if xvals.size>0
        attrvalues={}
        xvals.each do |y|
          attrvalues[y.attrib]=y.value if y.attrib and y.value
          y.destroy
        end
        # now attrvalues has the attribute values needed for the createcall
        # the Sugar adapter will use the name_value_list variable that we're building up here
        # TODO: name_value_list is probably too specific to Sugar, although we've made it work with other apps
        #  need a clean way to pass the attrvalues hash to any source adapter cleanly
        nvlist=make_name_value_list(attrvalues)
        if @source.source_adapter
          name_value_list=eval(nvlist)
          @source.source_adapter.create(name_value_list)
        else
          raise ArgumentError,"Need some create code to execute" if @source.createcall.nil?
          callbinding=eval("name_value_list="+nvlist+";"+@source.createcall+";binding",callbinding)
        end
      end
    end

    # now do the updates
    updates=ObjectValue.find_by_sql("select * from object_values where update_type='update' and source_id="+id)
    uniqobjs=updates.map {|x|x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      objvals=ObjectValue.find_all_by_object_and_update_type(x,'update')  # this has all the attribute value pairs now
      attrvalues={}
      attrvalues["id"]=x  # setting the ID allows it be an update
      objvals.each do |y|
        attrvalues[y.attrib]=y.value
        y.destroy
      end
      # now attrvalues has the attribute values needed for the createcall
      nvlist=make_name_value_list(attrvalues)
      if @source.source_adapter
        name_value_list=eval(nvlist)
        @source.source_adapter.update(name_value_list)
      else
        raise ArgumentError,"Need some update code to execute" if @source.updatecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+@source.updatecall+";binding",callbinding)
      end
    end


    # now do the deletes
    deletes=ObjectValue.find_by_sql("select * from object_values where update_type='delete' and source_id="+id)
    uniqobjs=deletes.map {|x|x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      attrvalues={}
      attrvalues["id"]=x
      nvlist=make_name_value_list(attrvalues)
      if @source.source_adapter
        name_value_list=eval(nvlist)
        @source.source_adapter.delete(name_value_list)
      else
        raise ArgumentError,"Need some delete code to execute" if @source.deletecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+@source.deletecall+";binding",callbinding)
      end
    end
    deletes.each do |x|  # get rid of the deletes
      x.destroy
    end
      
    # do the query call and sync of records
    if @source.source_adapter
      @source.source_adapter.query
      @source.source_adapter.sync
    else
      callbinding=eval(@source.call+";binding",callbinding)
      callbinding=eval(@source.sync+";binding",callbinding) if @source.sync
    end
    ObjectValue.delete_all "(update_type='query') and source_id="+@source.id.to_s
    ObjectValue.find_by_sql("update object_values set update_type='query',id=pending_id where (update_type='pending' or update_type is null) and source_id="+@source.id.to_s)

    # now do the logoff
    if @source.source_adapter
      @source.source_adapter.logoff
    else
      if @source.epilog and @source.epilog.size>0
        callbinding=eval(@source.epilog+";binding",callbinding)
      end
    end

    @source.refreshtime=Time.new  # keep track of the refresh time to help optimize show queries
    @source.save
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