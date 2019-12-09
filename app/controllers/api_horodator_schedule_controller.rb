class ApiHorodatorScheduleController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  before_action :authenticate!

  def start_horodator

    last_schedule = HorodatorSchedule.where(user: current_user, end_status: 0)
    if(last_schedule.length != 0)
      last_schedule.each do |ls|
        ls.end_status = 1
        ls.save
      end
    end 

    horodator_schedule = HorodatorSchedule.new
    horodator_schedule.user = current_user
    horodator_schedule.end_status = 0

    if(horodator_schedule.save)

      user = current_user
      user.ip = params[:ip]
      user.mac = params[:mac]
      user.start = DateTime.now
      user.save
      
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

    last_schedule = HorodatorSchedule.where(user: current_user, end_status: 0)
    if(last_schedule.length != 0)
      last_schedule.each do |ls|
        ls.end_status = 1
        ls.save
      end
    end 
    
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
