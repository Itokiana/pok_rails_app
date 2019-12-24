class UsersController < ApiApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password]
    )
    if user.save!
      payload = {user_id: user.id}
      token = encode_token(payload)
      render json: { email: user.email, jwt: token }
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end


end
