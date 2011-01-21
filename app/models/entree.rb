class Entree < ActiveRecord::Base
  has_many :meals
  has_many :recipes, :through => :meals

  validates :name, :presence => true
end
