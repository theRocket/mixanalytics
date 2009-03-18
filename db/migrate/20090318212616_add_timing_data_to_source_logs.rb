class AddTimingDataToSourceLogs < ActiveRecord::Migration
  def self.up
    add_column :source_logs, :timing, :float
  end

  def self.down
    remove_column :source_logs, :timing
  end
end
