class AddIndexToClientMap < ActiveRecord::Migration
  def self.up
    add_index :client_maps,[:client_id,:object_value_id],:name=>'client_map'
    add_index :clients,:client_id
  end

  def self.down
    remove_index :client_maps,:name=>:client_map
    remove_index :clients,:client_id
  end
end
