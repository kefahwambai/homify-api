class HomeOwnersController < ApplicationController
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
      render json: { token: token }, status: :created
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

  # Use callbacks to share common setup or constraints between actions.
  def set_home_owner
    @home_owner = HomeOwner.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def home_owner_params
    params.permit(:name, :email, :password, :password_confirmation, :bio, :image)
  end
end