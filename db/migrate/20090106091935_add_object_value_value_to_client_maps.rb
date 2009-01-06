class AddObjectValueValueToClientMaps < ActiveRecord::Migration
  def self.up
    add_column :client_maps, :object_value_value, :string
  end

  def self.down
    remove_column :client_maps, :object_value_value
  end
end
