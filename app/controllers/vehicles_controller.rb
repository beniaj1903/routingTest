class VehiclesController < ActionController::Base
    skip_before_action :verify_authenticity_token, :only => :create
    def create
        if params[:vehicle][:driver_id] == 'Sin conductor'
            params[:vehicle][:driver_id] = nil
        end
        vehicle = params[:vehicle]
        vehicle = Vehicle.create(name: vehicle[:name], driver_id: vehicle[:driver_id],
        load_type: vehicle[:load_type], capacity: vehicle[:capacity])
        if !vehicle.driver_id.nil?
            driver = Driver.find(vehicle.driver_id)
            driver.vehicle_id = vehicle.id
            driver.save
        end
        redirect_back fallback_location: @post
    end

    def delete
        Assignation.delete_all
        vehicle = Vehicle.find(params[:vehicle_id])
        vehicle.destroy
        redirect_back fallback_location: @post
    end
end