# Users
User.create!(username:              "admin",
             email:                 "admin@example.com",
             password:              "1q@W3e$R",
             password_confirmation: "1q@W3e$R",
             confirmed_at:          Time.zone.now,
             role:                  :admin)

password = "1qazXSW@"
User.create!(username:              "moderator",
             email:                 "moderator@example.com",
             password:              password,
             password_confirmation: password,
             confirmed_at:          Time.zone.now,
             role:                  :moderator)

User.create!(username:              "user",
             email:                 "user@example.com",
             password:              password,
             password_confirmation: password,
             confirmed_at:          Time.zone.now)

7.times do |n|
  username  = Faker::Internet.unique.username(separators: %w[- _])
  User.create!(username:              username,
               email:                 "#{username}@example.com",
               password:              password,
               password_confirmation: password,
               confirmed_at:          Time.zone.now)
end

# Posts and comments
users = User.all
posts_content = Faker::Hipster.paragraphs(number: 11)
comments_content = Faker::Hipster.sentences(number: 10)
posts_content.each do |post_content|
  post = users.sample.posts.create!(content: post_content)
  3.times do
    post.comments.create!(content: comments_content.sample, user: users.sample)
  end
end

last_post = Post.first
28.times do
  last_post.comments.create!(content: comments_content.sample,
                             user: users.sample)
end

# Votes
posts = Post.all
users[3..9].each do |user|
  users[0].upvote_by user
  users[1].downvote_from user
  users[2..9].sample.upvote_by user

  posts.first.upvote_by user
  posts[1..5].sample.upvote_by user
  posts[6..10].sample.downvote_from user
end
