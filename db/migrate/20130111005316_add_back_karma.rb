class AddBackKarma < ActiveRecord::Migration
  def change
    add_column :users, :good_karma, :integer
    add_column :users, :bad_karma, :integer
  end
end
