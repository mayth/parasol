# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    name 'Tatara Kogasa'
    sequence(:email) {|n| "kogasa-#{n}@example.com"}
    password 'pass30rd'
    password_confirmation 'pass30rd'
  end
end
