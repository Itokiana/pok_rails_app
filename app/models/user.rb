class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP
end