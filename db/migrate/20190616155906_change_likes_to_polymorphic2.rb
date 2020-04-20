class ChangeLikesToPolymorphic2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :commentable_id, :likable_id
    rename_column :likes, :commentable_type, :likable_type
  end
end
