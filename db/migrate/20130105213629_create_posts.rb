class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :text
      t.string :user
      t.integer :upvote
      t.integer :downvote
      t.integer :id
      t.integer :comment_count

      t.timestamps
    end
  end
end
