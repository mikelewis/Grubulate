class AddCommentCount < ActiveRecord::Migration
  def self.up
    add_column :recipes, :comments_count, :integer, :default => 0

    Recipe.reset_column_information

    Recipe.all.each do |r|
      Recipe.update_counters r.id, :comments_count => r.comments.length
    end
  end

  def self.down
    remove_column :recipes, :comments_count
  end
end
