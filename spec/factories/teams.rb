FactoryGirl.define do
  factory :team do
    sequence(:name) {|n| "Team #{n}"}
    sequence(:email) { |n| "team-mail-#{n}@example.com" }
    password 'pass30rd'
    password_confirmation { |u| u.password }
  end
end
