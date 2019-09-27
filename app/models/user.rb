class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :confirmable, :validatable,
         password_length: 8..70, authentication_keys: [:username]

  validate :password_complexity
  validates :username, uniqueness: true, length: { minimum: 1, maximum: 50 }
  validates :email, uniqueness: true
  has_many :posts

  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  extend FriendlyId
  friendly_id :username, use: :slugged

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private

  def password_complexity
    if password.present? and not password.match(/\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/)
     errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  def set_default_role
    self.role ||= :user
  end
end
