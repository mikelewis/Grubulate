class CreateEntreeRecipeTable < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.integer :recipe_id, :null => false
      t.integer :entree_id, :null => false
    end
  end

  def self.down
    drop_table :meal
  end
end
