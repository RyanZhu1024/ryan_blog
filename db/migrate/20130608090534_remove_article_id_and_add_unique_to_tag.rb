class RemoveArticleIdAndAddUniqueToTag < ActiveRecord::Migration
	def change
		change_column :tags,:name,:string,unique:true
		# remove_column :tags,:article_id
	end
end
	