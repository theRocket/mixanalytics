require "xml/libxml"

class ObjectValue < ActiveRecord::Base
  set_primary_key :id
  belongs_to :source
  has_many :clients, :through => :client_maps
  has_many :client_maps
  
  attr_accessor :db_operation

  def before_validate
  end
  
  def before_save
    self.id=hash_from_data(self.attrib,self.object,self.update_type,self.source_id,self.user_id,rand,self.value)
    self.pending_id = hash_from_data(self.attrib,self.object,self.update_type,self.source_id,self.user_id,self.value)    
  end
  
  def hash_from_data(attrib=nil,object=nil,update_type=nil,source_id=nil,user_id=nil,random=nil,value=nil)
    "#{object}#{attrib}#{update_type}#{source_id}#{user_id}#{random}#{value}".hash.to_i
  end
end
