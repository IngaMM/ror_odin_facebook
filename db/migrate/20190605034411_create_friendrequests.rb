class CreateFriendrequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendrequests do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :friendrequests, :sender_id
    add_index :friendrequests, :receiver_id 
    add_index :friendrequests, [:sender_id, :receiver_id], unique: true
  end
end
