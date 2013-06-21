class AddReceiverIdAndSenderIdToComment < ActiveRecord::Migration
  def change
  	add_column :comments,:receiver_id,:integer
  	add_column :comments,:sender_id,:integer,:null=>false
  end
end
