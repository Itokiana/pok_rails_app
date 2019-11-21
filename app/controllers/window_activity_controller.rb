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
    window.started_at = DateTime.new(params[:startedAt])
    window.ended_at = DateTime.new(params[:endedAt])
    window.total_focus = WindowActivityHelper.total_focus(DateTime.new(params[:startedAt]), DateTime.new(params[:endedAt]))
    
    if(window.save)
      render json: { :success => "ok" }
    end
  end

  def test_date
    render json: { :date => DateTime.parse("2019-11-21T08:28:19.651Z") .strftime("%d-%m-%y %H:%I") }
  end
end
