class UpdateClientMapsColumns < ActiveRecord::Migration
  def self.up
    remove_index :client_maps, :name => 'client_map'
    remove_column :client_maps, :object_value_object
    remove_column :client_maps, :object_value_attrib
    remove_column :client_maps, :object_value_value
    remove_column :client_maps, :db_operation
    
    add_index :client_maps,[:client_id,:object_value_id],:name=>'client_map_c_id_ov_id'
    add_index :client_maps,[:client_id],:name=>'client_map_c_id'
  end

  def self.down
    add_column :client_maps, :object_value_object, :string
    add_column :client_maps, :object_value_attrib, :string
    add_column :client_maps, :object_value_value, :string
    add_column :client_maps, :db_operation, :string
    
    remove_index :client_maps, 'client_map_c_id_ov_id'
    remove :client_maps,'client_map_c_id'
    add_index :client_maps,[:client_id,:object_value_id,:object_value_attrib,:object_value_value,:db_operation],:name=>'client_map'
  end
end