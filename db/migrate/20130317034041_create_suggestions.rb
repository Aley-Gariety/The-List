class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title
      t.string :text
      t.integer :user_id
      t.integer :user_id
      t.integer :comment_count

      t.timestamps
    end
  end
end
