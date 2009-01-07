class AddPendingIdToObjectValues < ActiveRecord::Migration
  def self.up
    add_column :object_values, :pending_id, :integer
  end

  def self.down
    remove_column :object_values, :pending_id
  end
end
