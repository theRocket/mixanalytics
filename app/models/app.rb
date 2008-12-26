class App < ActiveRecord::Base
  has_many :sources
  has_many :users, :through=>:subscriptions # these are the users that are allowed to access the source for query, create, update, delete
  has_many :subscriptions
end
