class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV['SECRET_KEY'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    if decoded_token = decode_token
      return nil unless decoded_token[0]['expired'] > Time.current.to_i
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def authorize
    render json: { message: 'Please log in' }, status: :unauthorized unless authorized_user
  end
end
