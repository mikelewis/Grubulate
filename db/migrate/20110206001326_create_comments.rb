class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :recipe_id

      t.timestamps
    end

    add_index :comments, :recipe_id
  end

  def self.down
    remove_index :comments, :recipe_id
    drop_table :comments
  end
end
