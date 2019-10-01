class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
end
