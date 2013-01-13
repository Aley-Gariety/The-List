class RemoveGoodKarmaAndBadKarmaFromUser < ActiveRecord::Migration
	def change
	remove_column :users, :good_karma
	remove_column :users, :bad_karma
	end
end
