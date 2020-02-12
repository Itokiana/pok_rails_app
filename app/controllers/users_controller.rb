class UsersController < ApiApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login

  def create
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password],
      token: (0...30).map { o[rand(o.length)] }.join,
      team: Team.first
    )
    if user.save!
      payload = {user_id: user.id, token: user.token}
      token = encode_token(payload)
      render json: { id: user.id, email: user.email, jwt: token }
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  def update
    p "######################################"
    p params[:user][:id]
    p "######################################"
    user =  User.find(params[:user][:id])
    user.password = params[:user][:password]
    if user.save!
      respond_to do |f|
        # f.html
        f.js
      end
      # render json: { message: "Saved with success" }
    else
      render json: { message: "Failed to save" }
    end
  end


end
