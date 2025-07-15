FactoryBot.define do
  factory :opportunity do
    title { "MyString" }
    description { "MyString" }
    salary { 1 }
    client { nil }
    job_applications_count { 1 }
  end
end
