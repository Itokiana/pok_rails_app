class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable
  include RailsJwtAuth::Recoverable

  validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP

  has_many :horodator_schedules
  belongs_to :team, optional: true
end