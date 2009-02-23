class CreateObjectValues < ActiveRecord::Migration
  def self.up
    create_table :object_values do |t|
      t.integer :id
      t.integer :source_id
      t.string :object
      t.string :attrib
      t.string :value
      t.integer :pending_id
      t.string :update_type
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :object_values
  end
end
