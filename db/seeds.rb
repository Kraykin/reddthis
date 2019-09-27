# Users
User.create!(username:              "adm",
             email:                 "admin@example.com",
             password:              "1q@W3e$R",
             password_confirmation: "1q@W3e$R",
             confirmed_at:          Time.zone.now)

30.times do |n|
  username  = Faker::Internet.unique.username(separators: %w[- _])
  password = "1qazXSW@"
  User.create!(username:              username,
               email:                 "#{username}@example.com",
               password:              password,
               password_confirmation: password,
               confirmed_at:          Time.zone.now)
end

# Roles
users = User.take(10)
users.first.admin!
users[1..3].each { |u| u.moderator! }

# Posts
content = Faker::Hipster.paragraphs(number: 10)
5.times do
  content.each do |post|
    users.sample.posts.create!(content: post)
  end
end
