class Source < ActiveRecord::Base
  include SourcesHelper
  has_many :object_values
  belongs_to :app
  attr_accessor :source_adapter,:current_user,:credential

  def before_validate
    self.initadapter
  end

  def before_save
    self.pollinterval||=300
    self.priority||=3
  end
  
  def initadapter
    #create a source adapter with methods on it if there is a source adapter class identified
    if self.adapter and self.adapter.size>0
      @source_adapter=(Object.const_get(self.adapter)).new(self)
    else # if source_adapter is nil it will
      @source_adapter=nil
    end
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

end
