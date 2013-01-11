class CahngeKaraDefaultToZero < ActiveRecord::Migration
  def change
    change_column_default(:users, :good_karma, 0)
    change_column_default(:users, :bad_karma, 0)
  end
end
