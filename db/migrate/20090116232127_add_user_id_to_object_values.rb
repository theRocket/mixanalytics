class AddUserIdToObjectValues < ActiveRecord::Migration
  def self.up
    add_column :object_values, :user_id, :integer
  end

  def self.down
    remove_column :object_values, :user_id
  end
end
