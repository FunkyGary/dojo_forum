class FavoriteCount < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :favorites_count, :integer, default: 0
  end
end
