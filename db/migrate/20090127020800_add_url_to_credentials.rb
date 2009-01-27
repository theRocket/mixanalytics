class AddUrlToCredentials < ActiveRecord::Migration
  def self.up
    add_column :credentials, :url, :string
  end

  def self.down
    remove_column :credentials, :url
  end
end
