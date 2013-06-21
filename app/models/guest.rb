class Guest < ActiveRecord::Base
  attr_accessible :email, :name

  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :email,:name
  validates_uniqueness_of :name
  validates :email,:format=>{:with=>VALID_EMAIL_REGEX},:uniqueness=>{:case_sensitive=>false}

  has_many :incoming_comments,:foreign_key=>"receiver_id",class_name:"Comment"
  has_many :outgoing_comments,:foreign_key=>"sender_id",class_name:"Comment"
end
