# app/models/user_observer.rb
class UserObserver < ActiveRecord::Observer
  #def after_create(user)
  #  UserMailer.deliver_signup_notification(user)
  #end

  def after_save(user) 
  # I BELIEVE THIS IS A BUG IN RESTFULAUTH!  UserMailer.deliver_activation(user) 
  end
end
