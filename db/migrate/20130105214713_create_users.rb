class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.integer :good_karma
      t.integer :bad_karma
      t.datetime :last_login
      t.integer :influence
      t.datetime :creation
      t.string :saved
      t.string :site
      t.string :full_name

      t.timestamps
    end
  end
end
