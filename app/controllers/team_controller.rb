class TeamController < ApplicationController
  def all
    render json: Team.all
  end

  def create
    @team = Team.new
    @team.name = params[:team][:name]
    if(@team.save)
      respond_to do |f|
        f.html { redirect_to settings_path }
        f.js
      end
    end
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def update
    team = Team.find(params[:id])
    team.name = params[:name]
    if(team.save)
      render json: { success: "saved"}
    end
  end

  def destroy
    team = Team.find(params[:id])
    @id = params[:id]
    if(team)
      team.users.each do |u|
        u.team = nil
        u.save
      end
      team.delete
      respond_to do |f|
        f.html { redirect_to settings_path }
        f.js
      end
    end
  end
end
