class AddColumnUserCommentCounts < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comment_counts, :integer, :default => 0
  end
end
