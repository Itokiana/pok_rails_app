class UserController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    respond_to do |f|
      f.js
      f.html
    end
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
