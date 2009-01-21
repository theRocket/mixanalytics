class Source < ActiveRecord::Base
  include SourcesHelper
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
    @client = SOAP::WSDLDriverFactory.new(url).create_rpc_driver if url and url.size>0 and url=~/wsdl/
    source_adapter.client=@client if source_adapter
    # make sure to use @client and @session_id variable in your code that is edited into each source!
    if source_adapter
      source_adapter.login  # should set up @session_id
    else
      callbinding=eval %"#{prolog};binding"
    end
    # also you can get user credentials from credential
    usersub=app.memberships.find_by_user_id(current_user.id) if current_user
    @credential=usersub.credential if usersub # this variable is available in your source adapter
    # perform core create, update and delete operations
    process_update_type('create',createcall)
    process_update_type('update',updatecall)
    process_update_type('delete',deletecall)      
    # do the query call and sync of records
    @user_id=User.find_by_login credential.login if credential
    if source_adapter
      source_adapter.query
      source_adapter.sync
    else
      callbinding=eval(call+";binding",callbinding)
      callbinding=eval(sync+";binding",callbinding) if sync
    end 
    finalize_query_records
    # now do the logoff
    if source_adapter
      source_adapter.logoff
    else
      if epilog and epilog.size>0
        callbinding=eval(epilog+";binding",callbinding)
      end
    end
    save
  end
  
  def finalize_query_records
    delete_cmd= "(update_type='query') and source_id="+id.to_s
    (delete_cmd << " and user_id="+ @user_id) if @user_id # if there is a credential then just do delete and update based upon the records with that credential
    ObjectValue.delete_all delete_cmd
    pending_to_query="update object_values set update_type='query',id=pending_id where (update_type='pending' or update_type is null) and source_id="+id.to_s
    (pending_to_query << " and user_id=" + @user_id) if @user_id 
    ObjectValue.find_by_sql pending_to_query
    updated_at=Time.new # timestamp    
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
end
