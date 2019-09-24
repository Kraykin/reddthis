class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 8..70

  validate :password_complexity
  validates :username, presence: true, length: { minimum: 1, maximum: 30 }
  has_many :posts

  extend FriendlyId
  friendly_id :username, use: :slugged

  private

  def password_complexity
    if password.present? and not password.match(/\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/)
     errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end
end
