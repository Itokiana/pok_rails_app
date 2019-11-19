class ApiInactivityController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  before_action :authenticate!

  def receive
    
    mouse_position = Inactivity.new
    mouse_position.horodator_schedule = HorodatorSchedule.find(params[:schedule].to_i)
    mouse_position.save
    render json: params[:started_at]

  end

end
