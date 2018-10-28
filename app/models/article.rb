class Article < ApplicationRecord
  validates_presence_of :title
  mount_uploader :image, PhotoUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def count_favorites
    self.favorites_count = self.favorites.size
    self.save
  end
end
