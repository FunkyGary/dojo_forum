class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :restaurant_id, :article_id
  end
end
