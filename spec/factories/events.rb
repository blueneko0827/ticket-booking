# spec/factories/users.rb
FactoryBot.define do
  factory :event do
    name { Faker::Internet.name }
    description { 'test' }
    location { 'dubai' }
    date { Time.now }
  end
end
