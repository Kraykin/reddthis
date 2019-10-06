FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Comment body #{n}" }
    user
    post
  end
end
