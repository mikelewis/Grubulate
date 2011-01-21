class Equipment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :appliance
end
