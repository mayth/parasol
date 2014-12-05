# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin-#{n}@aquarite.info" }
    password 'kogasa-ch@n'
  end
end
