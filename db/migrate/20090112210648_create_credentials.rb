class CreateCredentials < ActiveRecord::Migration
  def self.up
    create_table :credentials do |t|
      t.string :login
      t.string :password
      t.string :token
      t.integer :membership_id
      t.timestamps
    end
  end

  def self.down
    drop_table "credentials"
  end
end
