class DefaultIntegerColumnsToZero < ActiveRecord::Migration
  def change
    change_column :posts, :upvote, :integer, :default => 0
    change_column :posts, :downvote, :integer, :default => 0
    change_column :posts, :comment_count, :integer, :default => 0
    change_column :comments, :upvote, :integer, :default => 0
    change_column :comments, :downvote, :integer, :default => 0
    change_column :users, :good_karma, :integer, :default => 0
    change_column :users, :bad_karma, :integer, :default => 0
  end
end
