class ApiHorodatorScheduleController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  before_action :authenticate!

  def start_horodator

    user = User.where(:email => params[:email])[0]
    horodator_schedule = HorodatorSchedule.new
    horodator_schedule.user = user

    if(horodator_schedule.save)
      owner = {
        :type => 'Success',
        :start => horodator_schedule.created_at,
        :end => nil,
        :user => user.id,
        :schedule => horodator_schedule.id
      }
      render json: owner
    end

  end

  def test_user
    render json: current_user
  end

end
