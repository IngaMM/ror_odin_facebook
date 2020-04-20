class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :friend_id
      t.integer :befriended_id

      t.timestamps
    end
    add_index :friendships, :friend_id, unique: true
    add_index :friendships, :befriended_id, unique: true
  end
end
