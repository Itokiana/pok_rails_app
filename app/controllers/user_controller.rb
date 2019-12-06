class UserController < ApplicationController
  before_action :authenticate_admin!
  def index
    @schedules = HorodatorSchedule.where(end_status: 0)
  end

  def manage_users
    @users = User.all
  end

  def top_five_url
  end

  def top_five_app
  end

  def user_active
  end

  def create
    respond_to do |f|
      f.js
      f.html { redirect_to manage_users_path }
    end
  end

  def destroy
    user = RailsJwtAuth.model.find(params[:id])
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
