class Api::AuthController < ApiApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :require_login, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = encode_token(payload)
      render json: {email: user.email, jwt: token, success: "Bienvenue #{user.email} "}
    else
      render json: { failure: "Erreur de connexion!!!" }
    end
  end

  def auto_login
    if session_user
      render json: session_user
    else
      render json: { errors: "No User Logged In" }
    end
  end
end
