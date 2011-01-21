class CreateEquipmentTable < ActiveRecord::Migration
  def self.up
    create_table :equipments do |t|
      t.integer :recipe_id, :null => false
      t.integer :appliance_id, :null => false
    end
  end

  def self.down
    drop_table :equipments
  end
end
