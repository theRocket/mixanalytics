class AddBlobToObjectValues < ActiveRecord::Migration
  def self.up
    add_column :object_values, :blob_file_name, :string
    add_column :object_values, :blob_content_type, :string
    add_column :object_values, :blob_file_size, :integer
  end

  def self.down
    remove_column :object_values, :blob_file_name
    remove_column :object_values, :blob_content_type
    remove_column :object_values, :blob_file_size
  end
end
