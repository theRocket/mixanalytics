class AddAutoRegisterToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :autoregister, :integer
  end

  def self.down
    remove_column :apps, :autoregister
  end
end
