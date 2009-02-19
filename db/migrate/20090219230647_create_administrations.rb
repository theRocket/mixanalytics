class CreateAdministrations < ActiveRecord::Migration
  def self.up
    create_table :administrations do |t|
      t.integer :app_id 
      t.integer :user_id 
      t.timestamps
    end
  end

  def self.down
  end
end
