class SessionsController < RailsJwtAuth::SessionsController
  protect_from_forgery with: :null_session

  include RailsJwtAuth::AuthenticableHelper
  before_action :authenticate!, only: ['destroy']

  def create
    super
  end

  def destroy
    super
  end
end
