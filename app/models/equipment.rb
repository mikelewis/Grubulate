class Equipment < ActiveRecord::Base
  set_table_name "equipments"
  belongs_to :recipe
  belongs_to :appliance
end
