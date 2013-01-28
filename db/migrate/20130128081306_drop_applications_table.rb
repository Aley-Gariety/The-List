class DropApplicationsTable < ActiveRecord::Migration
  def change
    drop_table :applications
  end
end
