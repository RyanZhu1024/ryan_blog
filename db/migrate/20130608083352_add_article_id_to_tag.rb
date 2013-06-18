class AddArticleIdToTag < ActiveRecord::Migration
  def change
  	add_column :tags,:article_id,:string
  end
end
