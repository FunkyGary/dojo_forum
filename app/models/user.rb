class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :comments, dependent: :restrict_with_error
  has_many :commented_articles, through: :comments, source: :article
  has_many :favorites, dependent: :destroy
  has_many :favorited_articles, through: :favorites, source: :article
  has_many :articles
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  def admin?
    self.role == "admin"
  end
end
