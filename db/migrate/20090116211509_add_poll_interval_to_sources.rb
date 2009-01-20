class AddPollIntervalToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :pollinterval, :integer
  end

  def self.down
    remove_column :sources, :pollinterval
  end
end
