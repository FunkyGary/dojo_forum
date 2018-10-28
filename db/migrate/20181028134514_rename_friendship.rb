class RenameFriendship < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :friend_id, :following_id
  end
end
