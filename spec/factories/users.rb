FactoryBot.define do
  factory :user do
    username { "first-user" }
    email { "first-user@example.com" }
    password { "1q@W3e$R" }
    password_confirmation { "1q@W3e$R" }
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
