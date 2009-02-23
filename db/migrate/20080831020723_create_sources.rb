class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.string :name
      t.string :url
      t.string :login
      t.string :password
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
