class Api::AuthController < ApiApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      user.token = (0...30).map { o[rand(o.length)] }.join
      user.save
      payload = {user_id: user.id, token: user.token}
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

# eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJsYXN0X2xvZ2luIjoiMjAxOS0xMi0yNlQwOTozMzo0OSswMzowMCJ9.-R3AyC5mhHK14UF5acl9FC102HAQaZErKYmzz24flPE
# eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJsYXN0X2xvZ2luIjoiMjAxOS0xMi0yNlQwOTozNDoyOCswMzowMCJ9.UaBjH3LErZYT5HO-c3lsJeQZaO9U62ZdLdnKUCDw0Dc