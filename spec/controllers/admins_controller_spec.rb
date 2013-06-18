require 'spec_helper'
require 'pp'

describe AdminsController do

	before(:each) do	#to create a admin data
		@admin=FactoryGirl.build(:admin)
		@admin.password_confirmation=@admin.password
		@admin.save
	end

	describe "Delete request for admins" do

		it "should redirect_to sign_in_admins_path after log out" do
			#to login as an admin
			post :log_in,admin:{name:@admin.name,password:@admin.password}
			expect(session[:admin]).to eq "ryan"
			controller.should_receive(:should_be_admin)
			delete :log_out
			response.should redirect_to sign_in_admins_path
			session[:admin].should be_nil
		end
	end

	describe "Post request for admins" do
		it "should log_in with right name and password" do
			controller.should_receive(:admin_logged_in)
			post :log_in,admin:{name:@admin.name,password:@admin.password}
			session[:admin].should eq 'ryan'
		end
	end

	describe "Get request for admins" do
	  	it "should receive admin_logged_in when action is sign_in" do
	  		controller.should_receive(:admin_logged_in)
	  		get :sign_in
	  		expect(response).to be_success
	  	end
	end
end
