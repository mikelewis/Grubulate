class Profile < ActiveRecord::Base
  belongs_to :user
  validates :username, :presence => true, :uniqueness => true
  validates :bio, :length => {:maximum => 1000}

  attr_accessible :username, :bio, :avatar
  
  #friendly url
  has_friendly_id :username
  
  #profile pic
  has_attached_file :avatar, :styles => { :small => "150x150#", :thumb => "100x100" }
end
