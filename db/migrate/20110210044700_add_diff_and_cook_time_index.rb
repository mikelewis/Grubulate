class AddDiffAndCookTimeIndex < ActiveRecord::Migration
  def self.up
    add_index :recipes, :cook_time
    add_index :recipes, :difficulty
  end

  def self.down
    remove_index :recipes, :column => :difficulty
    remove_index :recipes, :column => :cook_time
  end
end
