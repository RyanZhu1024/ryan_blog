class AddUniquenessToArticleContentLink < ActiveRecord::Migration
  def change
  	change_column :articles,:content_link,:string,:unique => true
  end
end
