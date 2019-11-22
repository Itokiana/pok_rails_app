class HorodatorSchedule < ApplicationRecord
  belongs_to :user
  has_many :inactivities
  has_many :windows
  has_many :url_visited
end
