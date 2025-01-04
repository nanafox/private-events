class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[github]

  validates :fullname, :username, presence: true

  has_many :events, inverse_of: "creator", dependent: :delete_all

  # Events that this user has attended
  has_many :attendances, dependent: :delete_all
  has_many :attended_events, through: :attendances

  def to_param
    username
  end

  def fullname_with_username
    "#{fullname}(@#{username})"
  end

  # Checks if the current user is the owner of the specified event.
  #
  # Owners are those who created the event.
  def owns_event?(event)
    event.creator == self
  end

  # Checks whether a user is attending or attended the provided event.
  def attending?(event)
    attended_events.include?(event)
  end

  # Returns the full name of the user.
  def name
    fullname
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.fullname = auth.info.name
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
