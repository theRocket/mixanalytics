class App < ActiveRecord::Base
  has_many :sources
  has_many :users, :through=>:memberships # these are the users that are allowed to access the source for query, create, update, delete
  has_many :memberships
  has_many :administrations
  
  def to_param
    name.gsub(/[^a-z0-9]+/i, '-') unless new_record?
  end
  
  def self.find_by_permalink(link)
    App.find(:first, :conditions => ["id =:link or name =:link", {:link=> link}])
  end
end
