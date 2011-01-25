class AddBioToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :bio, :text
  end

  def self.down
    remove_column :profiles, :bio
  end
end
