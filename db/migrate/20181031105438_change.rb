class Change < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :following_id, :friend_id
  end
end
