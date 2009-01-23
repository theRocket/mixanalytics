class AddPriorityToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :priority, :integer
  end

  def self.down
    remove_column :sources, :priority
  end
end
