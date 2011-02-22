class RenameMisspellingNotification < ActiveRecord::Migration
  def self.up
    rename_column :notifications, :receiever_id, :receiver_id
  end

  def self.down
    rename_column :notifications, :receiver_id, :receiever_id
  end
end
