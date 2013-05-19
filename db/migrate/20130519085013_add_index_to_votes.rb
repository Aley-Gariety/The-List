class AddIndexToVotes < ActiveRecord::Migration
  def up
  	add_index :votes, [:post_id, :value]
  end
  def down
  	remove_index :votes, [:post_id, :value]
  end
end
