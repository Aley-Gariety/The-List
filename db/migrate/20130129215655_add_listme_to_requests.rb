class AddListmeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :listme, :boolean
  end
end
