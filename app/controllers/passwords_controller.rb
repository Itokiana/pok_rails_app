class PasswordsController < RailsJwtAuth::PasswordsController
  protect_from_forgery with: :null_session

  def update
    user = RailsJwtAuth.model.find(params[:id])
    user.update_with_password(params[:password])
  end
end
