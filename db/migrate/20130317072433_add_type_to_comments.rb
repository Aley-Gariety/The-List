class AddTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_type, :integer
  end
end
