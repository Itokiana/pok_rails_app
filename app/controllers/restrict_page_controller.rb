class RestrictPageController < ApplicationController
  before_action :authenticate_admin!
  def manage_user
    @users = User.all
  end
end
