# Sets up a many-to-many relationship between users and events.
# This means that multiples users can attend multiple events and multiple
# events can be attended by any number of users.
class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: "User", foreign_key: "user_id"
  belongs_to :attended_event, class_name: "Event", foreign_key: "event_id"
end
