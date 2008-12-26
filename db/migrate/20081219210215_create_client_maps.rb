class CreateClientMaps < ActiveRecord::Migration
  def self.up
    create_table :client_maps, :id => false do |t|
      t.string :client_id, :limit => 36
      t.string :object_value_id
      t.string :db_operation
      
      t.timestamps
    end
  end

  def self.down
    drop_table :client_maps
  end
end
