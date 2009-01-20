class Source < ActiveRecord::Base
  has_many :object_values
  belongs_to :app
  attr_accessor :source_adapter,:current_user,:credential

  def before_validate
    self.initadapter
  end

  def initadapter
    #create a source adapter with methods on it if there is a source adapter class identified
    if self.adapter and self.adapter.size>0
      @source_adapter=(Object.const_get(self.adapter)).new(self)
    else # if source_adapter is nil it will
      @source_adapter=nil
    end
  end

  # useful to be able to have the source adapter code available for viewing in YAML files
  def save_to_yaml
    File.open(name+'.yml','w') do |out|
      out.puts to_yaml
    end
  end
  
  def needs_refresh
    result=nil
    # refresh if there are any updates to come
    result=true if (ObjectValue.count_by_sql "select count(*) from object_values where update_type!='query' and source_id="+id.to_s) > 0
    # refresh if there is no data
    result=true if (ObjectValue.count_by_sql "select count(*) from object_values where update_type=='query' and source_id="+id.to_s) == 0
    # refresh is the data is old
    pollinterval=pollinterval if pollinterval and pollinterval>60  # minimum of 1 minute
    pollinterval||=300 # 5 minute default if there's no pollinterval or its a bad value
    result=true if (Time.new-updated_at)>pollinterval
    result  # return true of false (nil)
  end
  
  def refresh(current_user)
    @current_user=current_user
    initadapter
    # not all endpoints require WSDL! dont do this if you dont see WSDL in the URL (a bit of a hack)
    client = SOAP::WSDLDriverFactory.new(url).create_rpc_driver if url and url.size>0 and url=~/wsdl/
    source_adapter.client=client if source_adapter
    # make sure to use @client and @session_id variables
    # in your code that is edited into each source!
    if source_adapter
      source_adapter.login
    else
      callbinding=eval %"#{prolog};binding"
    end
    # also you can get user credentials from credential
    usersub=app.memberships.find_by_user_id(current_user.id) if current_user
    @credential=usersub.credential if usersub # this variable is available in your source adapter

    # first do all the the creates
    creates=ObjectValue.find_by_sql("select * from object_values where update_type='create' and source_id="+id.to_s)
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
        if source_adapter
          name_value_list=eval(nvlist)
          source_adapter.create(name_value_list)
        else
          raise ArgumentError,"Need some create code to execute" if createcall.nil?
          callbinding=eval("name_value_list="+nvlist+";"+createcall+";binding",callbinding)
        end
      end
    end

    # now do the updates
    updates=ObjectValue.find_by_sql("select * from object_values where update_type='update' and source_id="+id.to_s)
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
      if source_adapter
        name_value_list=eval(nvlist)
        source_adapter.update(name_value_list)
      else
        raise ArgumentError,"Need some update code to execute" if updatecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+updatecall+";binding",callbinding)
      end
    end


    # now do the deletes
    deletes=ObjectValue.find_by_sql("select * from object_values where update_type='delete' and source_id="+id.to_s)
    uniqobjs=deletes.map {|x|x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      attrvalues={}
      attrvalues["id"]=x
      nvlist=make_name_value_list(attrvalues)
      if source_adapter
        name_value_list=eval(nvlist)
        source_adapter.delete(name_value_list)
      else
        raise ArgumentError,"Need some delete code to execute" if deletecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+deletecall+";binding",callbinding)
      end
    end
    deletes.each do |x|  # get rid of the deletes
      x.destroy
    end
      
    # do the query call and sync of records
    user_id=User.find_by_login credential.login if credential
    if source_adapter
      source_adapter.query
      source_adapter.sync
    else
      callbinding=eval(call+";binding",callbinding)
      callbinding=eval(sync+";binding",callbinding) if sync
    end
    
    # if there is a user credential just manage the object value records associated with that user
    user_id=User.find_by_login credential.login if credential
    delete_cmd= "(update_type='query') and source_id="+id.to_s
    (delete_cmd << " and user_id="+user_id) if user_id # if there is a credential then just do delete and update based upon the records with that credential
    ObjectValue.delete_all delete_cmd
    pending_to_query="update object_values set update_type='query',id=pending_id where (update_type='pending' or update_type is null) and source_id="+id.to_s
    (pending_to_query << " and user_id="+user_id) if user_id 
    ObjectValue.find_by_sql pending_to_query
    updated_at=Time.new # timestamp

    # now do the logoff
    if source_adapter
      source_adapter.logoff
    else
      if epilog and epilog.size>0
        callbinding=eval(epilog+";binding",callbinding)
      end
    end

    refreshtime=Time.new  # keep track of the refresh time to help optimize show queries
    save
  end
  
end
