class RemoveMinTimeFromRecipe < ActiveRecord::Migration
  def self.up
    add_column :recipes, :cook_time, :integer
  end

  def self.down
    remove_column :recipes, :cook_time
  end
end
