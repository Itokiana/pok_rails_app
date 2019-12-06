class RegistrationsController < RailsJwtAuth::RegistrationsController
  protect_from_forgery with: :null_session

  def create
    super
  end

  def update
    super
  end

  def destroy
    user = RailsJwtAuth.model.find(params[:id])
    user.delete
    render json: { success: "Removed"}
  end
end
