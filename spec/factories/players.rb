FactoryGirl.define do
  factory :player do
    name 'Tatara Kogasa'
    sequence(:email) {|n| "kogasa-#{n}@example.com"}
    password 'pass30rd'
    password_confirmation 'pass30rd'
    team { create(:team) }
  end
end
