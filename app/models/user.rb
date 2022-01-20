class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  has_secure_token :auth_token

  has_many :comments

  before_create { self.regenerate_auth_token if auth_token.blank? }

  def self.create_user_for_google(data)
    where(uid: data["email"]).first_or_initialize.tap do |user|
      user.provider = "google_oauth2"
      user.uid = data["email"]
      user.email = data["email"]
      user.password = Devise.friendly_token[0, 20]
      user.password_confirmation = user.password
      user.save!
    end
  end

end
