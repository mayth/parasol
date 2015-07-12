# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "adm-#{n}@example.com" }
    password 'password012'
  end
end
