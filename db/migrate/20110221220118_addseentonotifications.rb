class Addseentonotifications < ActiveRecord::Migration
  def self.up
    add_column :notifications, :seen, :boolean, :default => false
  end

  def self.down
    remove_column :notifications, :seen
  end
end
