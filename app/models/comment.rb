class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  acts_as_votable
  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true
  mount_uploader :image, ImageUploader
end
