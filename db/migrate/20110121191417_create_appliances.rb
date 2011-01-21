class CreateAppliances < ActiveRecord::Migration
  def self.up
    create_table :appliances do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :appliances
  end
end
