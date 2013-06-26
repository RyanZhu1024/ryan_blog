# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest do
    sequence(:name){ |n|"guest#{n}"}
    sequence(:email){ |n|"guest#{n}@guest.com"}
  end
end
