FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "Post body #{n}" }
    user

    factory :post_with_comments do
      transient do
        comments_count { 3 }
      end

      after :create do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end
  end
end
