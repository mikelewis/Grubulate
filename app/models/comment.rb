class Comment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :profile

  validates :body, :presence => true, :length => {:minimum => 3, :maximum => 1000}
  validates :recipe_id, :presence => true
  validates :profile_id, :presence => true

end
