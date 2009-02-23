class CreateSourceLogs < ActiveRecord::Migration
  def self.up
    create_table :source_logs do |t|
      t.string :error
      t.string :message
      t.integer :time
      t.string :operation
      t.integer :source_id
      t.timestamps
    end
  end

  def self.down
    drop_table :source_logs
  end
end
