class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :confirmable, :validatable,
         password_length: 8..70, authentication_keys: [:username]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_votable
  scope :active_users, -> { where('deleted_at IS NULL') }

  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validate :password_complexity
  validates :username, uniqueness: { case_sensitive: false },
                       length: { minimum: 1, maximum: 50 }
  validates :email, uniqueness: { case_sensitive: false }

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
    regxp = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/
    if password && password !~ regxp
      msg = 'must include at least one lowercase letter, one uppercase letter, and one digit'
      errors[:password] << msg
    end
  end

  def set_default_role
    self.role ||= :user
  end
end
