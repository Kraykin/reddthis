FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "Post body #{n}" }
    user
  end
end
