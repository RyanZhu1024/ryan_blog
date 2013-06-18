class RemoveUniqueFromTag < ActiveRecord::Migration
	def change
		change_column :tags,:name,:string
	end
end
