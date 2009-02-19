class App < ActiveRecord::Base
  has_many :sources
  has_many :users, :through=>:memberships # these are the users that are allowed to access the source for query, create, update, delete
  has_many :memberships
  has_many :administrations
end
