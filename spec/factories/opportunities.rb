FactoryBot.define do
  factory :opportunity do
    title       { Faker::Job.title }
    description { Faker::Job.field }
    salary      { Faker::Number.between(from: 40_000, to: 200_000) }
    association :client
    job_applications_count { 0 }
  end
end
