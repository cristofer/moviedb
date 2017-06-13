FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@riskmethods.net" }    
    password "password"
  end
end
