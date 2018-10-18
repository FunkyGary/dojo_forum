class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.date :date
      t.text :description
      t.string :file_location
      t.integer :viewed_count
      t.integer :replies_count
      t.timestamps
    end
  end
end
