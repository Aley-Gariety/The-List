class FromTinyintToInt < ActiveRecord::Migration
  def change
    change_column(:votes, :vote_type, :integer)
  end
end
