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
      render json: { email: user.email, jwt: token }
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end


end
