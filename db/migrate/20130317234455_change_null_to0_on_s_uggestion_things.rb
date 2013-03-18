class ChangeNullTo0OnSUggestionThings < ActiveRecord::Migration
  def change
  	change_column_default(:suggestions, :comment_count, 0)
  end
end
