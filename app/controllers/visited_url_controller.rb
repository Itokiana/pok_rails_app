class VisitedUrlController < ActionController::API
  
  include RailsJwtAuth::AuthenticableHelper
  include WindowActivityHelper
  before_action :authenticate!

  def last_url
    url = UrlVisited.find_by url: params[:url], end_of_visit: nil
    if(url)
      render json: url
    else
      render json: { error: 'Not found' }
    end
  end

  def start_visit
    schedule = HorodatorSchedule.where(user: current_user, end_status: 0)[0]
    url = UrlVisited.new
    url.url = params[:url]
    url.date_of_visit = DateTime.now
    url.focus = 0
    url.total_focus = 0
    url.horodator_schedule = schedule
    url.start_focus = DateTime.now

    if(url.save!)
      render json: { success: 'Url saved' }
    end
  end

  def blur
    url = UrlVisited.find(params[:id])
    p "################################################"
    p url.start_focus.utc
    p  DateTime.now.utc
    p total_focus(url.start_focus.utc, DateTime.now.utc )
    p "################################################"
    url.focus = 0
    url.end_focus = DateTime.now
    url.total_focus = total_focus(DateTime.parse(url.start_focus.utc.to_s), DateTime.parse(DateTime.now.utc.to_s) ) + url.total_focus

    if(url.save)
      render json: { success: 'Url updated' }
    end
  end

  def focus
    url = UrlVisited.find(params[:id])
    url.focus = 1
    url.end_focus = nil
    url.start_focus = DateTime.now

    if(url.save)
      render json: { success: 'Url updated' }
    end
  end

  def end_visit
    url = UrlVisited.find(params[:id])
    url.focus = 1
    url.end_focus = DateTime.now
    url.end_of_visit = DateTime.now

    if(url.save)
      render json: { success: 'Url updated' }
    end
  end

end
