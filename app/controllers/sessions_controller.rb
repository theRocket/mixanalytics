# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  include UsersHelper
  
  # disable forgery protection for login
  # TODO: Only do this for json requests!
  protect_from_forgery :except => :client_login

  # render new.rhtml
  def new
  end
  
  def client_login
    logout_keeping_session!
    @app=App.find_by_permalink params[:app_id] if params[:app_id]
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
    else
      if @app and @app.autoregister  # if its a "autoregistering" app just go ahead and create the user
        create_user params[:login],params[:password],params[:email]
        redirect_back_or_default('/')
      else
        render :status => 401
      end
    end
  end

  def create
    p "create params: " + params.inspect.to_s
    logout_keeping_session!
    @app=App.find_by_permalink params[:app_id] if params[:app_id]
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      @current_user=user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      if @app and @app.autoregister
        create_user params[:login],params[:password],params[:email]
        redirect_back_or_default('/')
      else
        note_failed_signin
        @login       = params[:login]
        @remember_me = params[:remember_me]
        msg="Failed to login (bad password?)"
        flash[:notice] = msg
        @error=msg
        render :action => 'new'
      end
    end

  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
