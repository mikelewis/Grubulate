class Ingredient < ActiveRecord::Base
  has_many :foods
  has_many :recipes, :through => :foods

  validates :name, :presence => true

  attr_accessor :value

  def as_json(options={})
    {:value => name}
  end

  class << self
    def names_to_ids(ingredients)
      where(:name => ingredients).select('id').map{|e| e.id}
    end
  end
end
