class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiever_id
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps
    end

    add_index :notifications, :sender_id
    add_index :notifications, :receiever_id
    add_index :notifications, :notifiable_id
  end

  def self.down
    remove_index :notifications, :column => :notifiable_id
    remove_index :notifications, :column => :receiever_id
    remove_index :notifications, :column => :sender_id

    drop_table :notifications
  end
end
