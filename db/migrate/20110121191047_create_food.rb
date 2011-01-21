class CreateFood < ActiveRecord::Migration
  def self.up
    create_table :foods do |t|
      t.integer :recipe_id, :null => false
      t.integer :ingredient_id, :null => false
    end
  end

  def self.down
    drop_table :foods
  end
end
