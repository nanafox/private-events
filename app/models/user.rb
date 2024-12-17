class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, :username, presence: true

  has_many :events, inverse_of: "creator", dependent: :delete_all

  def to_param
    username
  end
end
