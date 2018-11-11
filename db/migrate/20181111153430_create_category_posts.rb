class CreateCategoryPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :category_posts do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "post_id"
      t.integer "category_id"

      t.timestamps
    end
  end
end
