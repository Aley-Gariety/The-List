class MoveToVotesModel < ActiveRecord::Migration
  def change
    remove_column :users, :good_karma
    remove_column :users, :bad_karma
    remove_column :posts, :upvote
    remove_column :posts, :downvote
    remove_column :comments, :parent_id
    remove_column :comments, :upvote
    remove_column :comments, :downvote
  end
end
