# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title 'Awesome title'
    body "The *quick brown* fox `jumps` over the lazy dog.\n" * 20
    public_scope 'admin'
  end
end
