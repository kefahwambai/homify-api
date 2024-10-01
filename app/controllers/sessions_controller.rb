class SessionsController < ApplicationController
  before_action :authorize_request, only: [:destroy]

  # Login action
  def create
    user = find_user_by_email(params[:email])
    
    if user&.authenticate(params[:password])
      token = AuthenticationTokenService.encode(user.id)
      render json: { user: { id: user.id, email: user.email, name: user.name }, token: token }, status: :ok
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # Logout action
  def destroy
    if @current_user
      # Optionally: If you're tracking sessions, you could invalidate it here
      render json: { status: 200, message: 'Logged out successfully' }, status: :ok
    else
      render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
    end
  end

  private

  def find_user_by_email(email)
    HomeOwner.find_by(email: email) || HomeBuyer.find_by(email: email)
  end

  def serialize_user(user)
    if user.is_a?(HomeOwner)
      HomeOwnerSerializer.new(user)
    else
      HomeBuyerSerializer.new(user)
    end
  end

  # This method checks for the Authorization header and decodes the JWT
  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    if token
      begin
        decoded_token = AuthenticationTokenService.decode(token)
        user_id = decoded_token[0]['user_id']
        @current_user = HomeOwner.find_by(id: user_id) || HomeBuyer.find_by(id: user_id)
      rescue JWT::DecodeError, JWT::ExpiredSignature
        render json: { message: 'Invalid or expired token' }, status: :unauthorized
      end
    else
      render json: { message: 'Token not provided' }, status: :unauthorized
    end
  end
end
