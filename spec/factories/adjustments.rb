FactoryGirl.define do
  factory :adjustment do
    point 100
    reason 'admin adjusts on the whim.'
    player { create(:player) }
  end
end
