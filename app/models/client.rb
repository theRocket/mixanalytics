require 'uuidtools'

class Client < ActiveRecord::Base
  has_many :client_maps
  
  def initialize(params=nil)
    super
    self.client_id = UUID.random_create.to_s unless self.client_id
  end
end
