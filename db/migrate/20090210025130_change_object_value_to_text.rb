class ChangeObjectValueToText < ActiveRecord::Migration
  def self.up
    change_column :object_values, :value, :text
  end

  def self.down
  end
end
