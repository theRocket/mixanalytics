class AddIndexToClientMap < ActiveRecord::Migration
  def self.up
=begin
    ClientMap.find_or_initialize_by_client_id_and_object_value_id_and_object_value_object_and_object_value_attrib_and_object_value_value(
                    {:client_id => client_id, 
                     :object_value_id => ov.id,
                     :object_value_object => ov.object,
                     :object_value_attrib => ov.attrib,
                     :object_value_value => ov.value,
                     :db_operation => 'insert'})
=end
    add_index :client_maps,[:client_id,:object_value_id,:object_value_attrib,:object_value_value,:db_operation],:name=>'client_map'
    add_index :clients,:client_id
  end

  def self.down
    remove_index :client_maps,:name=>:client_map
    remove_index :clients,:client_id
  end
end
