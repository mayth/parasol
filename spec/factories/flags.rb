FactoryGirl.define do
  factory :flag do
    point 200
    sequence(:flag) { |n| "FLAG_KOGASA_#{n}" }
  end
end
