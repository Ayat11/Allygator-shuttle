class Api::VehiclesController < ApplicationController

  before_action :get_vehicle_id
  before_action :get_location_info, only: :update_location

  def register
    Vehicle.create(identity: @vehicle_id)
    head :no_content
  end

  def update_location
    @vehicle = Vehicle.find_by(identity: @vehicle_id)
    if @vehicle.present?
      location = Location.new(lat: @lat, lng: @lng, retrieved_at: @time)
      location.vehicle = @vehicle
      location.save 
    end
    head :no_content
  end
  
  def de_register
    @vehicle = Vehicle.find_by(identity: @vehicle_id)
    @vehicle.delete if @vehicle.present?
  end

  def get_vehicles_updates
    vehicles_hash = {}
    locations = Location.order('vehicle_id, MAX(retrieved_at) DESC').select('DISTINCT on (vehicle_id) vehicle_id, lat, lng, MAX(retrieved_at)').group(:vehicle_id, :lat, :lng)
    locations = locations.joins(:vehicle)
    if locations.present?
      locations.each do |location|
        vehicles_hash[location.vehicle_id] = location
      end
    end
    if request.xhr?
      render json: {vehicles: vehicles_hash}
   end
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