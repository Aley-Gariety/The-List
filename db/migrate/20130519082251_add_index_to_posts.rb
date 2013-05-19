class AddIndexToPosts < ActiveRecord::Migration
  def up
  	add_index :posts, [:id, :created_at]
  end

  def down
  	remove_index :posts, [:id, :created_at]
  end
end
