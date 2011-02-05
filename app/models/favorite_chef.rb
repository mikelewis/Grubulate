class FavoriteChef < ActiveRecord::Base
  belongs_to :profile
  belongs_to :chef, :class_name => "Profile"

  validates :profile_id, :presence => true, :uniqueness => {:scope => :chef_id}
  validates :chef_id, :presence => true
end
