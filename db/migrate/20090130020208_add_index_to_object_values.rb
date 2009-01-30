class AddIndexToObjectValues < ActiveRecord::Migration
  def self.up
    # shouldnt need a named index but called it by_source_user_type anayway just in case
    add_index :object_values,[:source_id,:user_id,:update_type],:name=>'by_source_user_type'
  end

  def self.down
    remove_index :object_values,:name=>'by_source_user_type'
  end
end
