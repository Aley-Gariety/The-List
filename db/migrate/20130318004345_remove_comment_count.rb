class RemoveCommentCount < ActiveRecord::Migration
  def change
  	remove_column :posts, :comment_count
  	remove_column :suggestions, :comment_count
  end
end
