class UserController < ApplicationController
  def index
    @users = User.all
  end

  def create
    respond_to do |f|
      f.js
      f.html { redirect_to manage_users_path }
    end
  end
end
