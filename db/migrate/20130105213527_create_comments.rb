class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :user
      t.integer :post_id
      t.integer :comment_id
      t.integer :parent_id
      t.integer :upvote
      t.integer :downvote

      t.timestamps
    end
  end
end
