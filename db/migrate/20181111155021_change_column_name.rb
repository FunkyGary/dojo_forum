class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :category_posts, :post_id, :article_id
    add_column :articles, :category_id, :integer
  end
end
