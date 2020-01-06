class UserController < ApplicationController
  include UserHelper
  # before_action :authenticate_admin!, only: [:index, :manage_users, :create, :destroy]
  skip_before_action :authenticate_admin!, only: [:index, :manage_users, :create, :destroy]

  def index
  end

  def manage_users
    @users = User.all
    respond_to do |f|
      f.html
      f.js
    end
  end

  def total_schedule
    first_schedule = HorodatorSchedule.where(["created_at::date = ?", Date.today ]).limit(1)
    all_inactivity = Inactivity.where(["created_at::date = ?", Date.today])

    total_inactivity = 0

    all_inactivity.each do |ai|
      total_inactivity += ai.total
    end

    render json: { first_schedule: first_schedule[0] ? first_schedule[0].created_at : "0", total_inactivity: total_inactivity }
  end

  def top_five_url
    url_title_list = []
    urls = UrlVisited.where(["created_at::date = ?", Date.today])
    urls.each do |u|
      url_title_list << extract_host(u.url)
    end

    url_rates = Hash.new
    url_title_list.uniq.each do |utl|
      url_rates[utl] = UrlVisited.where(["url LIKE ?", "%#{utl}%"]).count
    end
    
    render json: url_rates.sort_by { |url, rate| -rate }[0, 5]
  end

  def top_five_app
    today_apps = Window.select(:title).where(["created_at::date = ?", Date.today]).distinct
    rates = Hash.new
    today_apps.each do |ta|
      rates[ta.title] = Window.where(["created_at::date = ? AND title = ?", Date.today, ta.title ]).count
    end

    render json: rates.sort_by { |title, rate| -rate }[0, 5]
  end

  def user_active
    schedules = HorodatorSchedule.where(end_status: 0)
    active_user = []
    if(schedules.length != 0)
      schedules.each do |s|
        user_schedules = HorodatorSchedule.where([ "created_at::date = ? AND user_id = ?", Date.today, s.user.id ])
        active_user << { 
          user_id: s.user.id, 
          email: s.user.email, 
          ip: s.user.ip, 
          mac: s.user.mac, 
          start: s.user.start, 
          top_inactivity: top_inactivity(s.user.id) 
        }
      end
    end
    
    render json: active_user
  end

  def create
    respond_to do |f|
      f.js
      f.html { redirect_to manage_users_path }
    end
  end

  def destroy
    user = User.find(params[:id])
    user.horodator_schedules.each do |hs|
      hs.windows.each do |w|
        w.delete
      end
      hs.inactivities.each do |i|
        i.delete
      end
      hs.url_visiteds.each do |uv|
        uv.delete
      end
      hs.delete
    end

    user.delete

    redirect_to manage_users_path

  end

end
