class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  # set up attendances for this event
  has_many :attendances
  has_many :attendees, through: :attendances

  validates :title, :location, :description, :date, presence: true
end
