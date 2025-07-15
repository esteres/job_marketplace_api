FactoryBot.define do
  factory :client do
    name { Faker::Company.name }
    email { Faker::Internet.unique.email(domain: 'example.com') }
  end
end
