# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(username:              "adm",
             email:                 "admin@example.com",
             password:              "1q@W3e$R",
             password_confirmation: "1q@W3e$R")

39.times do |n|
  username  = Faker::Superhero.name
  email = "user-#{n+1}@example.com"
  password = "1qazXSW@"
  User.create!(username:              username,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

# Posts
users = User.take(10)
40.times do
  content = Faker::Lorem.paragraph(sentence_count: rand(5..20))
  users.sample.posts.create!(content: content)
end
