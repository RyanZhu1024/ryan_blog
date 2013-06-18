class Admin < ActiveRecord::Base
	has_secure_password
	attr_accessible :name, :password

	validates_presence_of :name,:password,:password_confirmation
	validates_length_of :password,:minimum=>6
	validates_confirmation_of :password,:message=>"Should match the password"
end
