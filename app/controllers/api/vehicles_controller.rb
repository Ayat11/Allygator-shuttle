class Api::VehiclesController < ApplicationController

  before_action :get_vehicle_id
  before_action :get_location_info, only: :update_location

  def register
    Vehicle.create(identity: @vehicle_id)
  end

  def update_location
    @vehicle = Vehicle.find_by(identity: @vehicle_id)
    if @vehicle.present?
      @vehicle.locations << Location.create(lat: @lat, lng: @lng, retrieved_at: @time)
    end
  end
  
  def de_register
    @vehicle = Vehicle.find_by(identity: @vehicle_id)
    @vehicle.delete if @vehicle.present?
  end

  private

  def get_vehicle_id
    @vehicle_id = params[:id]
  end

  def get_location_info
    @lat = params[:lat]
    @lng = params[:lng]
    @time = params[:at]
  end
end