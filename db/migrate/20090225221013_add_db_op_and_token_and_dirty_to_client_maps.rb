class AddDbOpAndTokenAndDirtyToClientMaps < ActiveRecord::Migration
  def self.up
    add_column :client_maps, :db_operation, :string
    add_column :client_maps, :token, :integer
    add_column :client_maps, :dirty, :boolean, :default => false
  end

  def self.down
    remove_column :client_maps, :token
    remove_column :client_maps, :db_operation
    remove_column :client_maps, :dirty
  end
end
