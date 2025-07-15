# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"

puts "Seeding clients..."
clients = 10.times.map do
  Client.find_or_create_by!(email: Faker::Internet.unique.email) do |client|
    client.name = Faker::Company.name
  end
end

puts "Seeding job seekers..."
10.times.map do
  JobSeeker.find_or_create_by!(email: Faker::Internet.unique.email) do |js|
    js.name = Faker::Name.name
  end
end

puts "Seeding opportunities..."
clients.each do |client|
  2.times do
    Opportunity.find_or_create_by!(title: Faker::Job.title, client: client) do |opportunity|
      opportunity.description = Faker::Lorem.paragraph(sentence_count: 2)
      opportunity.salary = Faker::Number.between(from: 50_000, to: 150_000)
    end
  end
end

puts "Seeding done."
