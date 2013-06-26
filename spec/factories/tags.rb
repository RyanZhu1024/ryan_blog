# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :tag do
		secquence(:name){|n| "tag#{n}"}
	end
end
