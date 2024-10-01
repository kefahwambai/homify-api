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
    @house = House.new(house_params)
    
    if params[:house][:image].present?
      params[:house][:image].each do |image|
        @house.image.attach(image) 
      end
    end

    if params[:house][:video].present?
      @house.video.attach(params[:house][:video]) 
    end

    if params[:house][:pdf].present?
      @house.pdf.attach(params[:house][:pdf]) 
    end

    if @house.save
      render json: { message: "House created successfully" }, status: :created
    else
      render json: { errors: @house.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /houses/1
  def update
    if @house.update(house_params)
      render json: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # # DELETE /houses/1
  # def destroy
  #   if @house.home_owner == current_home_owner
  #     @house.destroy
  #     render json: { message: 'House was successfully destroyed.' }, status: :ok
  #   else
  #     render json: { error: 'Unauthorized' }, status: :unauthorized
  #   end
  # end

  # DELETE /houses/1
  def destroy
    if authorize_home_owner!(@house)
      @house.destroy
      render json: { message: 'House was successfully destroyed.' }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  # def authenticate_home_owner!
  #   token = request.headers['Authorization']&.split(' ')&.last
  #   Rails.logger.info "Token: #{token}"
  #   decoded_token = AuthenticationTokenService.decode(token)
  #   Rails.logger.info "Decoded token: #{decoded_token.inspect}"
  #   payload = decoded_token&.first

  #   if payload && AuthenticationTokenService.valid_payload(payload)
  #     @current_home_owner = HomeOwner.find_by(id: payload['user_id'])
  #     Rails.logger.info "Current Home Owner: #{@current_home_owner.inspect}"
  #     render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_home_owner
  #   else
  #     render json: { error: 'Unauthorized' }, status: :unauthorized
  #   end
  # end
  def authenticate_home_owner!
    token = request.headers['Authorization']&.split(' ')&.last
    Rails.logger.info("Received token: #{token}")
  
    if token.nil?
      Rails.logger.warn("Token not provided")
      render json: { error: 'Unauthorized' }, status: :unauthorized and return
    end
  
    decoded_token = AuthenticationTokenService.decode(token)
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless decoded_token
  
    Rails.logger.info("Decoded token: #{decoded_token.inspect}")
    @current_home_owner = HomeOwner.find_by(id: decoded_token['user_id'])
  
    if @current_home_owner.nil?
      Rails.logger.warn("HomeOwner not found")
      render json: { error: 'Unauthorized' }, status: :unauthorized and return
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
      :deposit,
      :currency,      
      :category,
      :duration,
      amenities: [],
      image: []
    )
  end

  # def attach_files(house)
  #   begin
  #     house.image.attach(params[:house][:image]) if params[:house][:image].present?
  #     house.video.attach(params[:house][:video]) if params[:house][:video].present?
  #     house.pdf.attach(params[:house][:pdf]) if params[:house][:pdf].present?
  #   rescue => e
  #     Rails.logger.error("File attachment failed: #{e.message}")
  #   end
  # end

  def authorize_home_owner!(house)
    house.home_owner == current_home_owner
  end
end
