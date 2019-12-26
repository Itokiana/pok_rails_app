class User < ApplicationRecord
  has_secure_password

  has_many :horodator_schedules
  belongs_to :team
end
