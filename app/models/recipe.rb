class Recipe < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 20

  validates :title, :presence => true
  validates :cook_time, :presence => true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :short_desc, :presence => true, :length => {:minimum => 5, :maximum => 255}
  validates :instructions, :presence => true, :length => {:minimum => 5, :maximum => 5000}
  validates :difficulty, :presence => true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5}

  belongs_to :profile
  has_many :meals
  has_many :entrees, :through => :meals

  has_many :foods
  has_many :ingredients, :through => :foods

  has_many :equipments
  has_many :appliances, :through => :equipments

  validates :ingredients, :presence => true

  attr_accessible :title, :short_desc, :instructions, :difficulty, :cook_time, :entree_ids, :ingredient_ids

  def add_ingredient(ingr)
    ingredients << ingr
  end

  def ingredientsNames
    ingredients.map{|e| e.name}.join(', ')
  end

  class << self
    
    #TODO
    # Default will be called by default browse
    def search(page)
      paginate :page => page, :order => "created_at DESC"
    end
  end
end