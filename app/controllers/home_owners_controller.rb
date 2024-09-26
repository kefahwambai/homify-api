class HomeOwnersController < ApplicationController
  before_action :authenticate_token, only: [:update]
  before_action :set_home_owner, only: %i[ show edit update destroy ]

  # GET /home_owners or /home_owners.json
  def index
    @home_owners = HomeOwner.all
    render json: @home_owners, status: :ok
  end

  # GET /home_owners/1 or /home_owners/1.json
  def show
    render json: @home_owner, status: :ok
  end

  # POST /home_owners or /home_owners.json
  def create
    @home_owner = HomeOwner.new(home_owner_params)
    if @home_owner.save
      token = AuthenticationTokenService.encode(@home_owner.id)
      render jsonac: { token: token }, status: :created
    else
      render json: @home_owner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /home_owners/1 or /home_owners/1.json
  def update
    if @home_owner.update(home_owner_params)
      render json: @home_owner, status: :ok
    else
      render json: @home_owner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /home_owners/1 or /home_owners/1.json
  def destroy
    @home_owner.destroy
    render json: { message: "Home owner was successfully destroyed." }, status: :ok
  end

  private

  def authenticate_token
    token = request.headers['Authorization']
    return render json: { error: 'Token not provided' }, status: :unauthorized unless token
    token = token.split(' ').last
    home_owner_id = AuthenticationTokenService.decode(token)
    Rails.logger.info "Decoded token: #{home_owner_id}"
    @home_owner = HomeOwner.find_by(id: home_owner_id)

    return render json: { error: 'Invalid token' }, status: :unauthorized unless @home_owner
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_home_owner
    @home_owner = HomeOwner.find(params[:id])
  end

  def home_owner_params
    params.require(:home_owner).permit(:name, :email, :password, :password_confirmation, :bio, :image)
  end
  
end
