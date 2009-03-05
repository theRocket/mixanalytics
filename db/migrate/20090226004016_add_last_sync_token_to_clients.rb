class AddLastSyncTokenToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :last_sync_token, :string
  end

  def self.down
    remove_column :clients, :last_sync_token
  end
end
