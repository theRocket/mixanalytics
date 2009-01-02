class AppsController < ApplicationController
  
  before_filter :login_required
  
  # GET /apps
  # GET /apps.xml
  def index
    login=@current_user.login.downcase
    @apps = App.find_all_by_admin login
    if @apps.nil?
      flash[:notice]="You have no existing apps"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.xml
  def show
    @app = App.find(params[:id])
    @sources=@app.sources
    @users=User.find :all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app }
    end
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
        format.html { redirect_to(@app) }
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
