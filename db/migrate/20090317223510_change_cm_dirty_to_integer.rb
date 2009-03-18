class ChangeCmDirtyToInteger < ActiveRecord::Migration
  def self.up
    change_column :client_maps, :dirty, :integer, :limit => 1, :default => 0
  end

  def self.down
    change_column :client_maps, :dirty, :boolean, :default => false
  end
end
