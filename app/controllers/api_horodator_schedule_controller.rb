class ApiHorodatorScheduleController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  before_action :authenticate!

  def start_horodator

    last_schedule = HorodatorSchedule.where(user: current_user, end_status: nil)
    if(last_schedule.length != 0)
      last_schedule[0].end_status = 1
    end 

    horodator_schedule = HorodatorSchedule.new
    horodator_schedule.user = current_user

    if(horodator_schedule.save)
      owner = {
        :type => 'Success',
        :start => horodator_schedule.created_at,
        :user => current_user.id,
        :schedule => horodator_schedule.id
      }
      render json: owner
    end

  end

  def end_horodator

    horodator_schedule = HorodatorSchedule.find(params[:schedule])
    horodator_schedule.end_status = 1

    if(horodator_schedule.save)
      owner = {
        :type => 'Success',
        :start => horodator_schedule.created_at,
        :end => horodator_schedule.updated_at,
        :user => current_user.id,
        :schedule => horodator_schedule.id
      }
      render json: owner
    end

  end

  def test_user
    render json: current_user
  end

end
