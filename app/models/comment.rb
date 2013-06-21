class Comment < ActiveRecord::Base
  attr_accessible :content,:receiver,:sender,:article_id

  belongs_to :article
  belongs_to :sender,class_name:"Guest"
  belongs_to :receiver,class_name:"Guest"

  validates_presence_of :content,:sender
end
