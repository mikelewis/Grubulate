require 'URLTempfile'
class Profile < ActiveRecord::Base
  ajaxful_rater
  belongs_to :user
  has_many :notifications, :foreign_key => "receiver_id", :order => 'created_at DESC', :include => [:sender, :notifiable]
  has_many :unseen_notifications, :class_name => "Notification", :foreign_key => "receiver_id", :conditions => {:seen => false}, :order => 'created_at DESC', :limit => 5, :include => [:sender, :notifiable]
  has_many :recipes

  has_many :fan_relationships, :class_name => "FavoriteChef", :dependent => :destroy
  has_many :fans, :through => :fan_relationships, :source => :chef

  has_many :favorite_chefs_relationships, :class_name => "FavoriteChef", :foreign_key => :chef_id, :dependent => :destroy
  has_many :favorite_chefs, :through => :favorite_chefs_relationships, :source => :profile

  has_many :comments

  validates :username, :presence => true, :uniqueness => true, :format => /[a-zA-Z0-9_]/, :length => {:minimum => 5, :maximum => 20}
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

  def num_unseen_notifications
    Notification.count(:conditions => {:receiver_id => id, :seen => false})
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

  def url_to_image(url,save)
      self.avatar = URLTempfile.new(url)
      self.save if save
  end

  def seen_notification(id)
    notification = notifications.find(id)
    notification.seen = true
    notification.save
  end
end
