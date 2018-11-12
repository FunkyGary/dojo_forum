class Article < ApplicationRecord
  validates_presence_of :title
  mount_uploader :image, PhotoUploader
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :category_articles, dependent: :destroy
  has_many :categories, through: :category_articles

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def count_favorites
    self.favorites_count = self.favorites.size
    self.save
  end

  def self.authorized_articles(user)
    Article.where(authority: "all").or(where(authority: "friend", user: user.friends)).or(where(authority: "myself", user: user))
  end
end
