class AddProfileIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :profile_id, :integer
    add_index :comments, :profile_id
  end

  def self.down
    remove_column :comments, :profile_id
    remove_index :comments, :profile_id
  end
end
