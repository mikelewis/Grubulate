class Profile < ActiveRecord::Base
  belongs_to :user
  validates :username, :presence => true, :uniqueness => true

  attr_accessible :username
end
