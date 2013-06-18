require 'spec_helper'
#rake watchr to run tests automatically
describe Admin do
	# pending "add some examples to (or delete) #{__FILE__}"
	it "should has name" do
		admin=Admin.new
		admin.save.should be_false
	end

	it "should has password" do
		admin=Admin.new
		admin.name="ryan"
		admin.save.should be_false
	end

	it "should has password_confirmation" do
		admin=Admin.new
		admin.name="ryan"
		admin.password="123456"
		admin.save.should be_false
	end

	it "should save fail when password length < 6" do
		admin=Admin.new
		admin.name="ryan"
		admin.password="123"
		admin.password_confirmation="123"
		admin.save.should be_false
	end

	it "should save fail with different password and password_confirmation" do
		admin=Admin.new
		admin.name="ryan"
		admin.password="123456"
		admin.password_confirmation="654321"
		admin.save.should be_false
	end

	it "should save fail with mass-assign password_confirmation" do
		expect do
			admin=Admin.create(name:"ryan",password:"123456",password_confirmation:"123456");
		end.to raise_exception
	end
end
