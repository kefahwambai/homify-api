class HousesController < ApplicationController
  before_action :authenticate_home_owner!, only: [:create, :update, :destroy]
  before_action :set_house, only: %i[show update destroy]

  # GET /houses
  def index
    @houses = House.all
    render json: @houses
  end

  # GET /houses/1
  def show
    render json: @house
  end

  # POST /houses
  def create
    authenticate_home_owner!
    @house = current_home_owner.houses.new(house_params)
    
    if @house.save
      attach_files(@house)
      render json: @house, status: :created, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1
  def update
    if @house.update(house_params)
      attach_files(@house)
      render json: @house
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

  def authenticate_home_owner!
    token = request.headers['Authorization']&.split(' ')&.last
    Rails.logger.info("Received token: #{token}")
    decoded_token = AuthenticationTokenService.decode(token)
    
    if decoded_token && AuthenticationTokenService.valid_payload(decoded_token)
      @current_home_owner = HomeOwner.find_by(id: decoded_token['user_id'])
      Rails.logger.info("Current HomeOwner: #{@current_home_owner.inspect}")
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
      :title,
      :description,
      :price,
      :image,
      :video,
      :video_url,
      :pdf,
      :address,
      :bathrooms,
      :bedrooms,
      :location,
      :squareFeet,
      :furnishingStatus,
      :parkingAvailability,
      :vehicles,
      :units,
      :deposit,
      :currency,      
      :category,
      :duration,
      amenities: [],
    )
  end

  def attach_files(house)
    house.image.attach(params[:house][:image]) if params[:house][:image].present?
    house.video.attach(params[:house][:video]) if params[:house][:video].present?
    house.pdf.attach(params[:house][:pdf]) if params[:house][:pdf].present?
  end
end
