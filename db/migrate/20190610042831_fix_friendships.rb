class FixFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, :friend_id
    remove_index :friendships, :befriended_id
    add_index :friendships, :friend_id
    add_index :friendships, :befriended_id
    add_index :friendships, [:friend_id, :befriended_id], unique: true
  end
end
