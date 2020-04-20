class AddIndexToComments < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, [:user_id, :created_at]
  end
end
