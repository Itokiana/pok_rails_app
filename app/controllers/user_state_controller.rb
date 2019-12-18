class UserStateController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  def index
    @user = User.find(params[:id])
  end

  def profil
    respond_to do |f|
      f.html { redirect_to user_state_path(params[:id]) }
      f.js
    end
  end

  def create_user_details
    user = User.find(params[:id])
    user.first_name = params[:user][:first_name]
    user.last_name = params[:user][:last_name]

    if(user.save)
      respond_to do |f|
        f.html { redirect_to user_state_path(params[:id]) }
        f.js
      end
    end
  end

  def add_user_team
    user = User.find(params[:id])
    user.team = Team.find(params[:user][:team])

    if(user.save)
      respond_to do |f|
        f.html { redirect_to user_state_path(params[:id]) }
        f.js
      end
    end
  end

  def update_password
    user = RailsJwtAuth.model.find(params[:id])
    user.update_with_password(params[:user][:password])
  end

  def all_windows_activities
    windows = Window.where(horodator_schedule: params[:id])

    render json: windows
  end

  def all_inactivities
    inactivities = Inactivity.where(horodator_schedule: params[:id])

    render json: inactivities
  end

  def all_url_visited
    urls_visited = UrlVisited.where(horodator_schedule: params[:id])

    render json: urls_visited
  end

end
