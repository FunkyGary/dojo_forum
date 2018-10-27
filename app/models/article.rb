class Article < ApplicationRecord
  validates_presence_of :title
  mount_uploader :image, PhotoUploader
  belongs_to :category
  has_many :comments
end
