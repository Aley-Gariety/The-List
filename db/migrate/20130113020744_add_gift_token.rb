class AddGiftToken < ActiveRecord::Migration
  def change
  	add_column :users, :gift_token, :string
  end

end
