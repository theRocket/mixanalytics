class AppsController < ApplicationController
  
  before_filter :login_required
  before_filter :find_app
  
  def getcred
    @sub=Membership.find params[:sub_id]
    if @sub and @sub.credential.nil?
      @sub.credential=Credential.new
      @sub.credential.save
      @sub.save
    end
  end
  
  def givecred
    @sub=Membership.find params[:sub_id]
    @sub.credential.login=params[:login]
    @sub.credential.password=params[:password]
    @sub.credential.token=params[:token]
    @sub.credential.url=params[:url]
    @sub.credential.save
    @sub.save
    flash[:notice]="Updated credential for membership"
    redirect_to :action=>'edit'
  end

  # GET /apps
  # GET /apps.xml
  def index
    login=@current_user.login.downcase 
    
    admins = @current_user.administrations
    @apps=admins.map { |a| a.app}
    if @apps.nil?
      flash[:notice]="You have no existing apps"
    end
    apps=App.find :all
    @subapps=apps.reject { |app| app.anonymous!=1 and !@current_user.apps.index(app) }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.xml
  def show
    @isadmin=Administration.find_by_user_id_and_app_id @current_user.id,@app.id  # is the current user an admin?  
    @sub=Membership.find_by_app_id_and_user_id @app.id,@current_user.id
    @sources=@app.sources
    @users=User.find :all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app }
    end
  end
  
  def refresh # execute a refresh on all sources associated with an app 
    @sources=Source.find_all_by_app_id @app.id,:order=>:priority
    @sources.each do |src|
      p "Refreshing " + src.name
      src.refresh(@current_user)
    end
    flash[:notice]="Refreshed all sources"
    redirect_to :action=>:edit
  end

  # GET /apps/new
  # GET /apps/new.xml
  def new
    @app = App.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @users = User.find :all
    @admins= Administration.find_all_by_app_id @app.id
    @isadmin=Administration.find_by_user_id_and_app_id @current_user.id,@app.id  # is the current user an admin?
    if !@isadmin 
      redirect_to :action=>"show"
    end
  end
  
  # subscribe specified subscriber to specified app ID
  def subscribe
    user=User.find_by_login params[:subscriber]
    @app.users << user
    if (params[:url]) # we have a URL of a credential
      @sub=Membership.find_by_user_id_and_app_id user.id,@app.id  # find the just created membership subscription
      @sub.credential=Credential.new
      @sub.credential.url=params[:url]
      @sub.credential.login=params[:login]
      @sub.credential.password=params[:password]
      @sub.credential.token=params[:token]
      @sub.credential.save
      @sub.save
    end
    redirect_to :action=>:edit
  end

  # unsubscribe subscriber to specified app ID 
  def unsubscribe
    @user=User.find_by_login params[:subscriber]    
    @app.users.delete @user
    redirect_to :action=>:edit
  end
  
  # add specified user as administrator
  def administer
    user=User.find_by_login params[:administrator]
    @app=App.find_by_permalink(params[:id])
    admin=Administration.new
    admin.user=user
    admin.save
    @app.administrations << admin
    redirect_to :action=>:edit
  end
  
  def unadminister
    admin=User.find_by_login params[:administrator]
    @app=App.find_by_permalink params[:id]
    administration=Administration.find_by_user_id_and_app_id admin.id,@app.id  
    p "Deleting administration " + administration.app_id.to_s + ":" + administration.user_id.to_s
    administration.delete
    redirect_to :action=>:edit
  end
  
  # POST /apps
  # POST /apps.xml
  def create
    @app = App.new(params[:app])
    @app.save
    admin=Administration.new
    admin.user_id=@current_user.id
    admin.app_id=@app.id
    admin.save
    
    respond_to do |format|
      if @app.save
        flash[:notice] = 'App was successfully created.'
        format.html { redirect_to(apps_url) }
        format.xml  { render :xml => @app, :status => :created, :location => @app }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.xml
  def update
    respond_to do |format|
      if @app.update_attributes(params[:app])
        flash[:notice] = 'App was successfully updated.'
        format.html { redirect_to(apps_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.xml
  def destroy
    @app.destroy

    respond_to do |format|
      format.html { redirect_to(apps_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_app
    @app = App.find_by_permalink(params[:id]) if params[:id]
  end
end
