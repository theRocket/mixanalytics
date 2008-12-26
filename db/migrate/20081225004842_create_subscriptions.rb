class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions, :id=>false do |t|
      t.integer :app_id 
      t.integer :user_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
