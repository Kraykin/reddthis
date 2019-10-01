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
users = User.first(10)
users.first.admin!
users[1].moderator!

# Posts and comments
posts = Faker::Hipster.paragraphs(number: 10)
comments = Faker::Hipster.sentences(number: 10)
3.times do
  posts.each do |post_content|
    post = users.sample.posts.create!(content: post_content)
    3.times { post.comments.create!(content: comments.sample, user: users.sample) }
  end
end
last_post = Post.first
30.times { last_post.comments.create!(content: comments.sample, user: users.sample) }
