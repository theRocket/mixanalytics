class AddIncrementalToSource < ActiveRecord::Migration
  def self.up
    add_column :sources, :incremental, :integer
  end

  def self.down
    remove_column :sources, :incremental
  end
end
