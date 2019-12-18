class WindowActivityController < ActionController::API

  include RailsJwtAuth::AuthenticableHelper
  include WindowActivityHelper
  before_action :authenticate!

  def receive
    schedule = HorodatorSchedule.where(user: current_user, end_status: 0)[0]

    if(schedule != nil)
      schedule.windows.each do |w|
        if(w != nil)
          w.total_focus += 0
          w.save
        end
      end
      last_window = Window.where(title: params[:title], horodator_schedule: schedule).order("created_at DESC").limit(1)
      if(last_window.length != 0)
        ltf = last_window[0].total_focus
        last_window[0].ended_at = DateTime.parse(DateTime.now.utc.to_s)
        p "#####################################################"
        p "STart => " + last_window[0].total_focus.to_s
        p ltf
        last_window[0].total_focus = total_focus(DateTime.parse(last_window[0].updated_at.utc.to_s), DateTime.parse(DateTime.now.utc.to_s) )
        p last_window[0].total_focus
        last_window[0].total_focus += ltf
        p last_window[0].total_focus
        p "#####################################################"
        
        if(last_window[0].save)
          render json: { :success => "ok" }
        end
      else
        window = Window.new
        window.title = params[:title]
        window.platform = params[:platform]
        window.x = params[:x]
        window.y = params[:y]
        window.width_screen = params[:widthScreen]
        window.height_screen = params[:heightScreen]
        window.started_at = DateTime.parse(params[:startedAt])
        window.ended_at = DateTime.parse(params[:endedAt]).strftime("%Y-%m-%d %H:%M:%S")
        window.total_focus = total_focus(DateTime.parse(params[:startedAt]), DateTime.now)
        window.horodator_schedule = schedule
        
        if(window.save)
          render json: { :success => "ok" }
        end
      end

    end

    
  end

  def test_date
    url = UrlVisited.last
    # total = total_focus(url.start_focus.utc, (url.start_focus.utc + (60*60)) )
    total = total_focus(DateTime.parse(url.start_focus.utc.to_s),  DateTime.parse((DateTime.now.utc).to_s) )
    # total = total_focus(DateTime.parse("2019-11-22T06:15:24.989Z"), DateTime.parse("2019-11-22T06:15:34.951Z"))
    render json: { :date => total, :type => DateTime.now.utc }
  end
end
