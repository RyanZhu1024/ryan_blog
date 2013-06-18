# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :article do
		title "My Fist Blog"
		sequence(:content_link){ |n|"/ryanblog/articles/#{n}/first_blog.html"}
		summary "This is my first blog. Good to see you."
	end
end
