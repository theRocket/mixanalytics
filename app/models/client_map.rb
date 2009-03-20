class ClientMap < ActiveRecord::Base
  belongs_to :client
  belongs_to :object_value
  
  # BEGIN client-sync methods
  
  # remove acknowledged token for client
  def self.mark_objs_by_ack_token(ack_token)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute "update client_maps set ack_token = 1 where token='#{ack_token}'"
    end
  end
  
  # get insert objects based on token status
  def self.get_insert_objs_by_token_status(join_conditions,client_id,resend_token)
    objs_to_return = ObjectValue.find_by_sql "select * #{join_conditions} where cm.ack_token = 0 \
                                              and cm.object_value_id is not NULL \
                                              and cm.db_operation != 'delete' \
                                              and cm.client_id = '#{client_id}' \
                                              and cm.token = #{resend_token} \
                                              order by ov.object"
    return objs_to_return.collect! {|x| x.db_operation = 'insert'; x}
  end
  
  # get delete objects based on token status
  def self.get_delete_objs_by_token_status(client_id)
    objs_to_return = []
    objs_to_delete = ClientMap.find_by_sql "select * from client_maps where ack_token = 0 \
                                            and client_id='#{client_id}' and db_operation = 'delete'"
    objs_to_delete.each do |map|
      objs_to_return << new_delete_obj(map.object_value_id)
    end
    objs_to_return
  end
  
  # look for changes in the current object_values list, return only records
  # for the current user if required
  def self.get_delete_objs_for_client(token,page_size,client_id)
    objs_to_return = []
    ActiveRecord::Base.transaction do
      objs_to_delete = ClientMap.find_by_sql "select * from client_maps cm left join object_values ov on \
                                              cm.object_value_id = ov.id \
                                              where cm.client_id='#{client_id}' and ov.id is NULL \
                                              and cm.dirty=0 order by ov.object limit #{page_size}"
      objs_to_delete.each do |map|
        objs_to_return << new_delete_obj(map.object_value_id)
        # update this client_map record with a dirty flag and the token, 
        # so we don't send it more than once
        ActiveRecord::Base.connection.execute "update client_maps set db_operation='delete',token='#{token}',dirty=1 where \
                                               object_value_id='#{map.object_value_id}' \
                                               and client_id='#{map.client_id}'"
      end
    end
    objs_to_return
  end
  
  # Add insert objects to client_maps based on 
  # join query w/ object_values
  def self.insert_new_client_maps(insert_query)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute "insert into client_maps 
                                             (client_id,object_value_id,db_operation,token) \
                                             #{insert_query}"                                      
    end
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