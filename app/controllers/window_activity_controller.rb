class WindowActivityController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  include WindowActivityHelper
  before_action :authenticate!

  def receive
    window = Window.new
    window.title = params[:title]
    window.platform = params[:platform]
    window.x = params[:x]
    window.y = params[:y]
    window.width_screen = params[:widthScreen]
    window.height_screen = params[:heightScreen]
    window.started_at = DateTime.parse(params[:startedAt]).strftime("%Y-%m-%d %H:%M:%S")
    window.ended_at = DateTime.parse(params[:endedAt]).strftime("%Y-%m-%d %H:%M:%S")
    window.total_focus = total_focus(DateTime.parse(params[:startedAt]), DateTime.parse(params[:endedAt]))
    window.horodator_schedule = HorodatorSchedule.find(params[:schedule])
    
    if(window.save)
      render json: { :success => "ok" }
    end
  end

  def test_date
    total = total_focus(DateTime.parse("2019-11-22T06:15:24.989Z"), DateTime.parse("2019-11-22T06:15:34.951Z"))
    render json: { :date => total }
  end
end
