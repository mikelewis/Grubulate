class AddProperIndexes < ActiveRecord::Migration
  def self.up
    add_index :recipes, :created_at
    add_index :recipes, :profile_id
    add_index :rates, :rateable_id
    add_index :profiles, :user_id, :unique => true

    add_index :meals, :entree_id
    add_index :meals, :recipe_id

    add_index :foods, :ingredient_id
    add_index :foods, :recipe_id

    add_index :favorite_chefs, :profile_id

    add_index :equipments, :appliance_id
    add_index :equipments, :recipe_id

    add_index :comments, :created_at
  end

  def self.down
    remove_index :comments, :column => :created_at

    remove_index :equipments, :column => :recipe_id
    remove_index :equipments, :column => :appliance_id

    remove_index :favorite_chefs, :column => :profile_id

    remove_index :foods, :column => :recipe_id
    remove_index :foods, :column => :ingredient_id

    remove_index :meals, :column => :recipe_id
    remove_index :meals, :column => :entree_id

    remove_index :profiles, :column => :user_id #unique
    remove_index :rates, :column => :rateable_id
    remove_index :recipes, :column => :profile_id
    remove_index :recipes, :column => :created_at
  end
end
