class Category < ApplicationRecord
  validates_presence_of :name
  has_many :articles, dependent: :restrict_with_error
end
