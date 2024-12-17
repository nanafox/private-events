class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :title, :location, :description, :date, presence: true
end
