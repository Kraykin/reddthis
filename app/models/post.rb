class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  mount_uploader :image, ImageUploader
end
