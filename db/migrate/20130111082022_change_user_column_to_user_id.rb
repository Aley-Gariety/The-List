class ChangeUserColumnToUserId < ActiveRecord::Migration
  def change
    rename_column :posts, :user, :user_id
    rename_column :comments, :user, :user_id
  end
end
