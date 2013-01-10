class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column :posts, :upvote, :integer, :default => 0
    change_column :posts, :downvote, :integer, :default => 0
  end
end
