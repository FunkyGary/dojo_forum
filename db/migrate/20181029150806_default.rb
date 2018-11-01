class Default < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:articles, :viewed_count, 0) 
    change_column_default(:articles, :replies_count, 0) 
  end
end
