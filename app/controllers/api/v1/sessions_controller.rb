class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_or_initialize_by(email: params[:email])
    user.password = params[:password] if user.password_digest.nil?
    user.save

    if user.errors.blank? && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id, expired: Time.now.to_i + 3600})
      render json: { user: user.email, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
