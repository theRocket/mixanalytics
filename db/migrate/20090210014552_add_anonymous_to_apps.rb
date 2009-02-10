class AddAnonymousToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :anonymous, :integer
  end

  def self.down
    remove_column :apps, :anonymous
  end
end
