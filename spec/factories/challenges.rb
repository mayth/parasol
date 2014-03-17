FactoryGirl.define do
  factory :challenge do
    name 'Challenge'
    genre 'binary'
    flags { 3.times.map { create(:flag) } }
  end
end
