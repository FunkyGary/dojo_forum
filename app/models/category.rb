class Category < ApplicationRecord
  validates_presence_of :name
  has_many :category_articles, dependent: :restrict_with_error
  has_many :articles, through: :category_articles 
end
