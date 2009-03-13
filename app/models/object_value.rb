require "xml/libxml"

class ObjectValue < ActiveRecord::Base
  set_primary_key :id
  belongs_to :source
  has_many :clients, :through => :client_maps
  has_many :client_maps
  has_attached_file :blob
  
  attr_accessor :db_operation

  def before_validate
  end
  
  def before_save
    if self.pending_id.nil?
      self.id=hash_from_data(self.attrib,self.object,self.update_type,self.source_id,self.user_id,self.value,rand)
      self.pending_id = hash_from_data(self.attrib,self.object,self.update_type,self.source_id,self.user_id,self.value)  
    else
      p "Record exists: " + self.inspect.to_s
    end  
  end
  
  def hash_from_data(attrib=nil,object=nil,update_type=nil,source_id=nil,user_id=nil,value=nil,random=nil)
    "#{object}#{attrib}#{update_type}#{source_id}#{user_id}#{value}#{random}".hash.to_i
  end
  
  # get insert objects based on token
  def self.get_insert_objs_by_token(join_conditions,token,page_size)
    objs_to_return = ObjectValue.find_by_sql "select * #{join_conditions} where cm.token = '#{token}' \
                                              and cm.object_value_id is not NULL \
                                              and cm.db_operation != 'delete' \
                                              order by ov.object"
    return objs_to_return.collect! {|x| x.db_operation = 'insert'; x}
  end
  
  # get delete objects based on token
  def self.get_delete_objs_by_token(token,page_size)
    objs_to_return = []
    objs_to_delete = ClientMap.find_by_sql "select * from client_maps where token = '#{token}' \
                                            and db_operation = 'delete'"
    objs_to_delete.each do |map|
      objs_to_return << new_delete_obj(map.object_value_id)
    end
    objs_to_return
  end
  
  
  # generates an object_value for the client
  # to delete
  def self.new_delete_obj(obj_id)
    temp_obj = ObjectValue.new
    temp_obj.object = nil
    temp_obj.db_operation = "delete"
    temp_obj.created_at = temp_obj.updated_at = Time.now.to_s
    temp_obj.attrib = nil
    temp_obj.value = '-'
    temp_obj.update_type = 'delete'
    temp_obj.id = obj_id
    temp_obj.source_id = 0
    temp_obj
  end
end
