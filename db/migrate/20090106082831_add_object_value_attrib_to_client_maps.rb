class AddObjectValueAttribToClientMaps < ActiveRecord::Migration
  def self.up
    add_column :client_maps, :object_value_attrib, :string
  end

  def self.down
    remove_column :client_maps, :object_value_attrib
  end
end
