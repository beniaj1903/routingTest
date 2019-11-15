class RoutesController < ActionController::Base
    def index #get routes
        render "index"
    end

    def assign
        # Separate the routes and vehicles/drivers in 2 types
        general_routes = Route.where(load_type: 'general')
        refrigerated_routes = Route.where(load_type: 'refrigerated')
        general_vehicles = Vehicle.where(load_type: 'general')
        refrigerated_vehicles = Vehicle.where(load_type: 'refrigerated')
        general_driver = Driver.where(vehicle: general_vehicles)
        refrigerated_drivers = Driver.where(load_type: 'refrigerated')

        # Order by important parameters
        # general_routes.order(:starts_at, :load_sum, :stops_amount)
        # general_dirvers.order(:available_at, :capacity)
        general_vehicles.order(:available_at, :max_number_of_stops)        
        # Iterate routes then drivers to assign them
        available_drivers = []
        assignations = []
        general_routes.each do |route|
            available_drivers = Driver.where("available_at < ? AND max_number_of_stops <= ?", route.starts_at, route.stops_amount).order(:available_at, :capacity)
            available_drivers.each do |driver|
                if route.cities & driver.cities == route.cities
                    if driver.vehicle_id.nil? 
                        vehicle = general_vehicles.where("available_at < ? AND capacity >= ?", route.starts_at, route.load_sum).order(:available_at, :max_number_of_stops).first
                        route.vehicle_id = vehicle.id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        vehicle.available_at = route.ends_at
                        driver.save
                        vehicle.save
                        assignations.push({driver: driver,vehicle: vehicle,route: route})
                        p '==============NOVEHICLEID============'
                        p '===================================='
                        p '===================================='
                        p 'ASIGNA DRIVER'
                        p driver
                        p 'ASIGNA VEHICLE'
                        p vehicle
                        p 'TO ROUTE'
                        p route
                        p '===================================='
                        p '===================================='
                        break
                    elsif driver.vehicle.capacity >= route.load_sum && driver.vehicle.load_type == 'general'
                        route.vehicle_id = driver.vehicle_id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        driver.vehicle.available_at = route.ends_at
                        driver.save
                        driver.vehicle.save
                        assignations.push({driver: driver,vehicle: driver.vehicle,route: route})
                        p '===================================='
                        p '===================================='
                        p 'ASIGNA DRIVER'
                        p driver
                        p 'ASIGNA VEHICLE'
                        p driver.vehicle
                        p 'TO ROUTE'
                        p route
                        p '===================================='
                        p '===================================='
                        break
                    end
                end
            end            
        end
        refrigerated_routes.each do |route|
            available_drivers = Driver.where("available_at < ? AND max_number_of_stops <= ?", route.starts_at, route.stops_amount).order(:available_at, :capacity)
            available_drivers.each do |driver|
                if route.cities & driver.cities == route.cities

                    if driver.vehicle_id.nil? 
                        vehicle = refrigerated_vehicles.where("available_at < ? AND capacity >= ?", route.starts_at, route.load_sum).order(:available_at, :max_number_of_stops).first
                        route.vehicle_id = vehicle.id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        vehicle.available_at = route.ends_at
                        driver.save
                        vehicle.save
                        assignations.push({driver: driver,vehicle: vehicle,route: route})
                        p '==============NOVEHICLEID============'
                        p '===================================='
                        p '===================================='
                        p 'ASIGNA DRIVER'
                        p driver
                        p 'ASIGNA VEHICLE'
                        p vehicle
                        p 'TO ROUTE'
                        p route
                        p '===================================='
                        p '===================================='
                        break
                    elsif driver.vehicle.capacity >= route.load_sum && driver.vehicle.load_type == 'refrigerated'
                        route.vehicle_id = driver.vehicle_id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        driver.vehicle.available_at = route.ends_at
                        driver.save
                        driver.vehicle.save
                        assignations.push({driver: driver,vehicle: driver.vehicle,route: route})
                        p '===================================='
                        p '===================================='
                        p 'ASIGNA DRIVER'
                        p driver
                        p 'ASIGNA VEHICLE'
                        p driver.vehicle
                        p 'TO ROUTE'
                        p route
                        p '===================================='
                        p '===================================='
                        break
                    end
                end
            end            
        end
        render json: {
            assignations: assignations,
          }
    end
end
