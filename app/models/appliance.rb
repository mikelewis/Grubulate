class Appliance < ActiveRecord::Base
  has_many :equipments
  has_many :recipes, :through => :equipments

  validates :name, :presence => true
end
