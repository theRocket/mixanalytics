class AppsController < ApplicationController
  
  before_filter :login_required
  
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
    @sub.credential.save
    @sub.save
    flash[:notice]="Updated credential for membership"
    redirect_to :action=>'index'
  end

  # GET /apps
  # GET /apps.xml
  def index
    login=current_user.login.downcase
    @apps = App.find_all_by_admin login
    if @apps.nil?
      flash[:notice]="You have no existing apps"
    end
    apps=App.find :all
    @subapps=apps.reject { |app| !current_user.apps.index(app) }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.xml
  def show
    @app = App.find params[:id]
    @sources=@app.sources
    @users=User.find :all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app }
    end
  end
  
  def refresh # execute a refresh on all sources associated with an app 
    @app=App.find params[:id]
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
    @app = App.find(params[:id]) 
    @users = User.find :all
  end
  
  # subscribe specified subscriber to specified app ID
  def subscribe
    user=User.find_by_login params[:subscriber]
    @app=App.find(params[:id])
    @app.users << user
    redirect_to :action=>:edit
  end

  # unsubscribe subscriber to specified app ID 
  def unsubscribe
    @app=App.find params[:id]
    @user=User.find_by_login params[:subscriber]    
    @app.users.delete @user
    redirect_to :action=>:edit
  end

  # POST /apps
  # POST /apps.xml
  def create
    
    @app = App.new(params[:app])
    @app.admin=current_user.login
    
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
    @app = App.find(params[:id])

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
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to(apps_url) }
      format.xml  { head :ok }
    end
  end
end
