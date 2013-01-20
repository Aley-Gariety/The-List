class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :post_id
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end
