class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_secure_token :auth_token

  has_many :comments

  before_create { self.regenerate_auth_token if auth_token.blank? }

end
