class ChangeObjectValuesId < ActiveRecord::Migration
  def self.up
    # drop cache table and re-create with no autoincrement
    drop_table :object_values
    create_table :object_values, :id => false do |t|
      t.integer :id
      t.integer :source_id
      t.string :attrib
      t.string :object
      t.string :value
      t.string :update_type
      t.timestamps
    end
  end

  def self.down
    drop_table :object_values
    create_table :object_values do |t|
      t.integer :source_id
      t.string :attrib
      t.string :object
      t.string :value
      t.string :update_type
      t.timestamps
    end
  end
end
