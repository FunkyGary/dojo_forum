class ArticlesPublic < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :public, :boolean, :default => true
  end
end
