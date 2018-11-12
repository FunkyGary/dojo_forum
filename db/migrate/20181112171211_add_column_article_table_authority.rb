class AddColumnArticleTableAuthority < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :authority, :string, :default => 'all'
  end
end
