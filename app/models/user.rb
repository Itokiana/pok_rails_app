class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP

  has_many :horodator_schedules
end