class Article < ApplicationRecord
  validates_presence_of :title
  mount_uploader :image, PhotoUploader
end
