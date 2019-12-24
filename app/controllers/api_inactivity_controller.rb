class ApiInactivityController < ActionController::API

  include ApiApplicationHelper
  before_action :require_login
  include WindowActivityHelper

  def receive

    last_inactivity = Inactivity.where([ "since = ?", DateTime.parse(params[:inactivity][:created_at]) ])
    if(last_inactivity)
      last_inactivity.each do |i|
        i.delete
      end
    end
    
    time_check = TimeCheck.last

    mouse_position = Inactivity.new
    mouse_position.horodator_schedule = HorodatorSchedule.find(params[:schedule].to_i)
    mouse_position.mouse_x = params[:inactivity][:x].to_i
    mouse_position.mouse_y = params[:inactivity][:y].to_i
    mouse_position.since = DateTime.parse(params[:inactivity][:created_at]) #.strftime("%Y-%m-%d %H:%M:%S")
    mouse_position.total = total_focus( DateTime.parse(params[:inactivity][:created_at]), DateTime.parse((DateTime.now.utc).to_s) ) + (time_check.inactivity / 1000)
    if(mouse_position.save)
      render json: { :inactivity_at => mouse_position.created_at, :to => DateTime.now.utc, :total => mouse_position.total }
    end
    

  end

end
