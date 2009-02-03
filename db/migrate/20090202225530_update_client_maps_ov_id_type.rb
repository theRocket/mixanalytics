class UpdateClientMapsOvIdType < ActiveRecord::Migration
  def self.up
    change_column :client_maps, :object_value_id, :integer
  end

  def self.down
    change_column :client_maps, :object_value_id, :string
  end
end
