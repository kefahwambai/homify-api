class HousesController < ApplicationController
  before_action :authenticate_home_owner!, only: [:create, :update, :destroy]
  before_action :set_house, only: %i[show update destroy]

  # GET /houses
  def index
    @houses = House.all
    render json: @houses, status: :ok
  end

  # GET /houses/1
  def show
    render json: @house, status: :ok
  end

  # POST /houses
  def create
    @house = current_home_owner.houses.new(house_params)

    if @house.save
      @house.image.attach(params[:house][:image]) if params[:house][:image].present?
      @house.video.attach(params[:house][:video]) if params[:house][:video].present?
      @house.pdf.attach(params[:house][:pdf]) if params[:house][:pdf].present?
      render json: @house, status: :created, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1
  def update
    # attach_files

    if @house.update(house_params)
      render json: @house, status: :ok
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # DELETE /houses/1
  def destroy
    if @house.home_owner == current_home_owner
      @house.destroy
      render json: { message: 'House was successfully destroyed.' }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def authenticate_home_owner!
    token = request.headers['Authorization']&.split(' ')&.last
    Rails.logger.info "Token: #{token}"
    decoded_token = AuthenticationTokenService.decode(token)
    Rails.logger.info "Decoded token: #{decoded_token.inspect}"
    payload = decoded_token&.first

    if payload && AuthenticationTokenService.valid_payload(payload)
      @current_home_owner = HomeOwner.find_by(id: payload['user_id'])
      Rails.logger.info "Current Home Owner: #{@current_home_owner.inspect}"
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_home_owner
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_home_owner
    @current_home_owner
  end

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(
      :title, :description, :price, :address, :bathrooms, :bedrooms,
      :category, :duration, :location, :squareFeet, :furnishingStatus, :currency,
      :parkingAvailability, :deposit, :vehicles, :video_url, :amenities,
      image: [], video: [], pdf: []
    )
  end

  # Handle file attachments for images, videos, and PDFs
  # def attach_files
  #   if params[:house][:image].present?
  #     @house.image.attach(params[:house][:image])
  #   end

  #   if params[:house][:video].present?
  #     @house.video.attach(params[:house][:video])
  #   end

  #   if params[:house][:pdf].present?
  #     @house.pdf.attach(params[:house][:pdf])
  #   end
  # end
end
