class ChangeLikesToPolymorphic < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :post_id, :commentable_id
    add_column :likes, :commentable_type, :string
  end
end
