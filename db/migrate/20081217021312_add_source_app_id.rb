class AddSourceAppId < ActiveRecord::Migration
  def self.up
    add_column :sources, :app_id, :integer
  end

  def self.down
  end
end
