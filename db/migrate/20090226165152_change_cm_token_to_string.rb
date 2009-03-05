class ChangeCmTokenToString < ActiveRecord::Migration
  def self.up
    change_column :client_maps, :token, :string
  end

  def self.down
    change_column :client_maps, :token, :integer
  end
end
