class Source < ActiveRecord::Base
  include SourcesHelper
  has_many :object_values
  has_many :source_logs
  belongs_to :app
  attr_accessor :source_adapter,:current_user,:credential

  def before_validate
    self.initadapter
  end

  def before_save
    self.pollinterval||=300
    self.priority||=3
  end
  
  def initadapter(credential)
    #create a source adapter with methods on it if there is a source adapter class identified
    if (credential and credential.url.blank?) or (!credential and self.url.blank?)
      msg= "Need to to have a URL for the source in either a user credential or globally"
      slog(nil,msg,self.id)
      raise msg
    end
    if not self.adapter.blank? 
      @source_adapter=(Object.const_get(self.adapter)).new(self,credential)
    else # if source_adapter is nil it will
      @source_adapter=nil
    end
  end
  
  def ask(current_user,question)
    usersub=app.memberships.find_by_user_id(current_user.id) if current_user
    self.credential=usersub.credential if usersub # this variable is available in your source adapter
    initadapter(self.credential)
    source_adapter.ask question
  end

  def refresh(current_user)
    @current_user=current_user
    logger.info "Logged in as: "+ current_user.login if current_user
    
    usersub=app.memberships.find_by_user_id(current_user.id) if current_user
    self.credential=usersub.credential if usersub # this variable is available in your source adapter
    initadapter(self.credential)   
    # make sure to use @client and @session_id variable in your code that is edited into each source!
    begin
      source_adapter.login  # should set up @session_id
    rescue Exception=>e
      p "Failed to login"
      slog(e,"can't login",self.id,"login")
    end
    process_update_type('create')
    process_update_type('update')
    process_update_type('delete')      
    clear_pending_records(@credential)
    begin
      p "Timing query"
      start=Time.new
      source_adapter.query
      tlog(start,"query",self.id)
    rescue Exception=>e
      slog(e,"timed out on query",self.id)
    end
    start=Time.new
    source_adapter.sync
    tlog(start,"sync",self.id)
    finalize_query_records(@credential)

    source_adapter.logoff
    save
  end

end
