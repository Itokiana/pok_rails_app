class TimeCheckController < ApplicationController
  def first
    render json: TimeCheck.last
  end

  def create
    time = TimeCheck.last
    time.application = params[:time_check][:application].to_i * 1000
    time.inactivity = params[:time_check][:inactivity].to_i * 1000
    time.inactivity_part = params[:time_check][:inactivity_part].to_i * 1000
    
    if(time.save)
      respond_to do |f|
        f.html { redirect_to settings_path }
        f.js
      end
    end
  end

  def destroy
    time = TimeCheck.find(params[:id])
    if(time)
      time.delete
      render json: { success: "removed"}
    end
  end
end
