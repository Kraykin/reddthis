FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(separators: %w[- _]) }
    email { "#{username}@example.com" }
    password { "1q@W3e$R" }
    password_confirmation { password }
    confirmed_at { Time.zone.now }

    factory :user_with_posts do
      transient do
        posts_count { 3 }
      end

      after :create do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
