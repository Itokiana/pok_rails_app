module ApiApplicationHelper

  def encode_token(payload)
    JWT.encode(payload, "glopopopy")
  end

  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      user_id = decoded_hash[0]['user_id']
      token = decoded_hash[0]['token']
      @user = User.find_by(id: user_id, token: token)
      p "##############################"
      p token
      p "##############################"
      @user
    else
      nil
    end
  end

  def current_user
    @user
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      # token = auth_header.split(' ')[1]
      begin
        JWT.decode(auth_header, "glopopopy", true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end

  def logged_in?
    !!session_user
  end

  def require_login
    render json: { message: 'Please Login'}, status: :unauthorized unless logged_in?
  end

end
