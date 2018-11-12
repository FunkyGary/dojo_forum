class RenameCategoryArticles < ActiveRecord::Migration[5.2]
  def change
    rename_table :category_posts, :category_articles
  end
end
