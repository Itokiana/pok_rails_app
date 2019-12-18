class SettingsController < ApplicationController
  def index
    @teams = Team.all
    @team = Team.new
    @time_check = TimeCheck.last
    if(!@time_check)
      @time_check = TimeCheck.new
      @time_check.application = 0
      @time_check.inactivity = 0
      @time_check.inactivity_part = 0
      @time_check.save
    else
      @time_check.application /= 1000
      @time_check.inactivity /= 1000
      @time_check.inactivity_part /= 1000
    end
  end

  def timecheck
    time_check = TimeCheck.last
    render json: time_check
  end
end
