class AddUsernameAndGoodKarmaAndBadKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username
    add_column :users, :good_karma, :integer
    add_index :users, :good_karma
    add_column :users, :bad_karma, :integer
    add_index :users, :bad_karma
  end
end
