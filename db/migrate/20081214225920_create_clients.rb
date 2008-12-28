class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients, :id => false do |t|
      t.string :client_id, :limit => 36, :primary => true
      t.string :session

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
