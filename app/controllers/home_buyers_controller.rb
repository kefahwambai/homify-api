class HomeBuyersController < ApplicationController
  before_action :set_home_buyer, only: %i[ show edit update destroy ]

  # GET /home_buyers or /home_buyers.json
  def index
    @home_buyers = HomeBuyer.all
    render json: @home_buyers, status: :ok
  end

  # GET /home_buyers/1 or /home_buyers/1.json
  def show
    render json: @home_buyer, status: :ok
  end

  # POST /home_buyers or /home_buyers.json
  def create
    @home_buyer = HomeBuyer.new(home_buyer_params)
    if @home_buyer.save
      token = AuthenticationTokenService.encode(@home_buyer.id)
      render json: { token: token }, status: :created
    else
      render json: @home_buyer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /home_buyers/1 or /home_buyers/1.json
  def update
    if @home_buyer.update(home_buyer_params)
      render json: @home_buyer, status: :ok
    else
      render json: @home_buyer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /home_buyers/1 or /home_buyers/1.json
  def destroy
    @home_buyer.destroy
    render json: { message: "Home buyer was successfully destroyed." }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_home_buyer
    @home_buyer = HomeBuyer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def home_buyer_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
