class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes

  accepts_nested_attributes_for :profile
end
