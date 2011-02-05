class CreateFavoriteChefs < ActiveRecord::Migration
  def self.up
    create_table :favorite_chefs do |t|
      t.integer :profile_id
      t.integer :chef_id

      t.timestamps
    end

    add_index :favorite_chefs, :chef_id, :unique => true
  end

  def self.down
    remove_index :favorite_chefs, :chef_id
    drop_table :favorite_chefs
  end
end
