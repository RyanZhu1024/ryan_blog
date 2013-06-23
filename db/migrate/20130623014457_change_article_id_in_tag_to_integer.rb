class ChangeArticleIdInTagToInteger < ActiveRecord::Migration
  def change
  	change_column :tags,:article_id,:integer
  end
end
