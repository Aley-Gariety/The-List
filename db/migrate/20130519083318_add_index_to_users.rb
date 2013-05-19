class AddIndexToUsers < ActiveRecord::Migration
  def up
  	add_index :users, :karma
  end

  def down
  	remove_index :users, :karma
  end
end
