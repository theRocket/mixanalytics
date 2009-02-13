class AddAnonymousUserToUsers < ActiveRecord::Migration
  def self.up
    User.create(:login => "anonymous", :password => "password", :password_confirmation=> "password", :email => "anonymous@rhomobile.com")
  end

  def self.down
  end
end
