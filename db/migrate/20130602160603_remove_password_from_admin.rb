class RemovePasswordFromAdmin < ActiveRecord::Migration
  def up
  	remove_column :admins,:password
  	add_column :admins,:password_digest,:string
  end

  def down
  	add_column :admins,:password,:string
  	remove_column :admins,:password_digest,:string
  end
end
