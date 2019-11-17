class DriversController < ActionController::Base
    skip_before_action :verify_authenticity_token, :only => :create
    def create
        if params[:driver][:vehicle_id] == 'Sin vehículo'
            params[:driver][:vehicle_id] = nil
        end
        params[:driver][:cities] = params[:driver][:cities].reject!(&:blank?)
        driver = params[:driver]
        driver = Driver.create(name: driver[:name], email: driver[:email], phone: driver[:phone], vehicle_id: driver[:vehicle_id],
        cities: driver[:cities], max_number_of_stops: driver[:max_number_of_stops])
        if !driver.vehicle_id.nil?
            vehicle = Vehicle.find(driver.vehicle_id)
            vehicle.driver_id = driver.id
            vehicle.save
        end
        redirect_back fallback_location: @post
    end

    def delete
        Assignation.delete_all
        driver = Driver.find(params[:driver_id])
        driver.destroy
        redirect_back fallback_location: @post
    end
end