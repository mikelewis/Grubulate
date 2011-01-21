class AddProfileIdToRecipe < ActiveRecord::Migration
  def self.up
    add_column :recipes, :profile_id, :integer
  end

  def self.down
    remove_column :recipes, :profile_id
  end
end
