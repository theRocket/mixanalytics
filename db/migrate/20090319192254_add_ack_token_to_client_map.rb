class AddAckTokenToClientMap < ActiveRecord::Migration
  def self.up
    add_column :client_maps, :ack_token, :integer, :limit => 1, :default => 0
    remove_column :client_maps, :updated_at
    remove_column :client_maps, :created_at
  end

  def self.down
    remove_column :client_maps, :ack_token
  end
end
