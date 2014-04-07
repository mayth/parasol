FactoryGirl.define do
  factory :challenge do
    name 'Challenge'
    genre 'binary'
    description "This is the description!\n" * 5
    flags { 3.times.map { create(:flag) } }
  end
end
