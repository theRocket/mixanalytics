class CreateClientMaps < ActiveRecord::Migration
  def self.up
    create_table :client_maps do |t|
      t.string :client_id
      t.string :obj_key
      t.string :update_type

      t.timestamps
    end
  end

  def self.down
    drop_table :client_maps
  end
end
