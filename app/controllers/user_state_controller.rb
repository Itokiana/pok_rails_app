class UserStateController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  def index
    @user = User.find(params[:id])
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
