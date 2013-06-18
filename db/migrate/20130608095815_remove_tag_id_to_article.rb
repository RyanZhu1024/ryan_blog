class RemoveTagIdToArticle < ActiveRecord::Migration
  def up
  	remove_column :articles,:tag_id
  end

  def down
  end
end
