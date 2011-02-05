class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :recipes

  has_many :fan_relationships, :class_name => "FavoriteChef", :dependent => :destroy
  has_many :fans, :through => :fan_relationships, :source => :chef

  has_many :favorite_chefs_relationships, :class_name => "FavoriteChef", :foreign_key => :chef_id, :dependent => :destroy
  has_many :favorite_chefs, :through => :favorite_chefs_relationships, :source => :profile

  validates :username, :presence => true, :uniqueness => true
  validates :bio, :length => {:maximum => 1000}

  attr_accessible :username, :bio, :avatar
  
  #friendly url
  has_friendly_id :username
  
  #profile pic
  has_attached_file :avatar, :styles => { :small => ["150x150#", :png], :thumb => ["50x50#", :png] }

  def create_recipe(recipe)
    return false unless recipe.valid?

    recipes << recipe
  end

  def add_favorite_chef(chef)
    favorite_chefs << chef
  end

  def remove_favorite_chef(chef)
    favorite_chefs.delete(chef)
  end

  def is_a_fan_of(profile)
    favorite_chefs.include?(profile)
  end

end
