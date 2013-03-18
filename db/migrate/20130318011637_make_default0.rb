class MakeDefault0 < ActiveRecord::Migration
  def change
    change_column_default :comments, :comment_type, 0
  end
end
