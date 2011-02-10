class Recipe < ActiveRecord::Base
  ajaxful_rateable :stars => 5, :cache_column => :rating_average
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

  has_many :comments, :dependent => :destroy
  has_many :most_recent_comments, :class_name => 'Comment', :order => 'created_at DESC', :limit => 10

  validates :ingredients, :presence => true

  attr_accessible :title, :short_desc, :instructions, :difficulty, :cook_time, :entree_ids, :ingredient_ids, :appliance_ids

  def add_ingredient(ingr)
    ingredients << ingr
  end

  def ingredientsNames
    ingredients.map{|e| e.name}.join(', ')
  end

  def appliancesNames
    appliances.map{|e| e.name}.join(', ')
  end

  def add_comment(attrs)
    if !attrs.is_a?(Hash)
      return false
    end
    comments.create(attrs)
  end


  def remove_comment(comment)
    comments.delete(comment)
  end

  class << self
    
    #TODO
    # Default will be called by default browse
    #def search(page)
    #  paginate :page => page, :order => "created_at DESC"
    #end

    def get_by_profile(page, profile)
      paginate :page => page, :order => "created_at DESC", :conditions => ["recipes.profile_id = ?", profile.id]
    end
  end
end
