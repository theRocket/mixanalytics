class AddObjectToClientMaps < ActiveRecord::Migration
  def self.up
    add_column :client_maps, :object_value_object, :string
  end

  def self.down
    remove_column :client_maps, :object_value_object
  end
end
