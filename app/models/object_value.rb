require "xml/libxml"

class ObjectValue < ActiveRecord::Base
  set_primary_key :id
  belongs_to :source
  has_many :clients, :through => :client_maps
  attr_accessor :db_operation

  def before_validate
    self.update_type="pending"
  end
  
  def before_save
    self.id = hash_from_data(self.attrib, self.object, self.value, self.update_type)
  end

  private
  def hash_from_data(attrib=nil,object=nil,value=nil,update_type=nil)
    "#{object}#{attrib}#{value}#{update_type}".hash.to_i
  end
end
