class HorodatorSchedule < ApplicationRecord
  belongs_to :user
  has_many :inactivities
end
