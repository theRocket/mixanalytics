class ClientMap < ActiveRecord::Base
  belongs_to :client
  belongs_to :object_value
end