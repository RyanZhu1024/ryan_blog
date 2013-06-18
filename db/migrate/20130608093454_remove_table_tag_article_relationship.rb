class RemoveTableTagArticleRelationship < ActiveRecord::Migration
  def up
  	drop_table :tag_article_relationships
  end

  def down
  	create_table :tag_article_relationships
  end
end
