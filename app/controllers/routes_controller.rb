class RoutesController < ActionController::Base
    skip_before_action :verify_authenticity_token, :only => :create
    def index #get routes
        @assignations = params[:assignations]
        @driver = Driver.new
        @vehicle = Vehicle.new
        render 'index'
    end

    def create
        params[:route][:cities] = params[:route][:cities].reject!(&:blank?)
        params[:route][:starts_at] = DateTime.parse(params[:route][:starts_at].to_s)
        params[:route][:ends_at] = DateTime.parse(params[:route][:ends_at].to_s)
        route = params[:route]
        Route.create(starts_at: route[:starts_at], ends_at: route[:ends_at], load_type: route[:load_type], 
        cities: route[:cities], stops_amount: route[:stops_amount], load_sum: route[:load_sum])
        redirect_back fallback_location: @post
    end

    def delete
        Assignation.delete_all
        Route.find(params[:route_id]).destroy
        redirect_back fallback_location: @post
    end

    def fill_db
        Assignation.delete_all
        Route.delete_all
        Vehicle.update_all(driver_id: nil)
        Driver.update_all(vehicle_id: nil)
        Vehicle.delete_all
        Driver.delete_all
        # Drivers
        [
          {name: 'particular1', phone: 977424260, email: 'particular1@test.cl', cities: ['Cerrillos','Las Condes', 'Lo Barnechea', 'Lo Prado', 'La Pintana'], max_number_of_stops: 6, vehicle_id: nil},
          {name: 'particular2', phone: 977424260, email: 'particular2@test.cl', cities: ['Las Condes', 'Quinta Normal', 'Huechuraba', 'Peñalolén', 'Ñuñoa'], max_number_of_stops: 5, vehicle_id: nil},
          {name: 'particular3', phone: 977424260, email: 'particular3@test.cl', cities: ['Las Condes', 'Estación Central', 'Lo Prado', 'Ñuñoa', 'La Florida'], max_number_of_stops: 4, vehicle_id: nil},
          {name: 'particular4', phone: 977424260, email: 'particular4@test.cl', cities: ['Las Condes', 'Lo Barnechea', 'Ñuñoa', 'Maipú', 'Quinta Normal'], max_number_of_stops: 1, vehicle_id: nil},
          {name: 'particular5', phone: 977424260, email: 'particular5@test.cl', cities: ['Las Condes', 'Providencia'], max_number_of_stops: 4, vehicle_id: nil},
          {name: 'flota1', phone: 977424260, email: 'flota1@test.cl', cities: ['Macul', 'La Pintana', 'Las Condes', 'Peñalolén', 'Pudahuel', 'Quinta Normal'], max_number_of_stops: 15, vehicle_id: nil},
          {name: 'flota2', phone: 977424260, email: 'flota2@test.cl', cities: ['Las Condes', 'Lo Barnechea', 'Lo Prado'], max_number_of_stops: 9, vehicle_id: nil},
          {name: 'flota3', phone: 977424260, email: 'flota3@test.cl', cities: ['Las Condes', 'Lo Espejo', 'Lo Barnechea', 'Ñuñoa', 'Quinta Normal'], max_number_of_stops: 5, vehicle_id: nil},
          {name: 'flota4', phone: 977424260, email: 'flota4@test.cl', cities: ['Pedro Aguirre Cerda', 'La Cisterna', 'Quilicura'], max_number_of_stops: 2, vehicle_id: nil},
          {name: 'flota5', phone: 977424260, email: 'flota5@test.cl', cities: ['Las Condes', 'Lo Barnechea', 'Lo Prado', 'Huechuraba', 'Renca', 'Conchalí', 'Providencia'], max_number_of_stops: 15, vehicle_id: nil},
        ].each do |driver_params|
          Driver.create(driver_params)
        end

        # Vehicles
        [
            {name: 'flota1', load_type: 'general', capacity: 17, driver_id: nil},
            {name: 'flota2', load_type: 'refrigerated', capacity: 17, driver_id: nil},
            {name: 'flota3', load_type: 'general', capacity: 17, driver_id: nil},
            {name: 'flota4', load_type: 'general', capacity: 17, driver_id: nil},
            {name: 'flota5', load_type: 'refrigerated', capacity: 17, driver_id: nil},
            {name: 'particular1', load_type: 'general', capacity: 17, driver_id: Driver.find_by( email: 'particular1@test.cl').id},
            {name: 'particular2', load_type: 'general', capacity: 17, driver_id: Driver.find_by( email: 'particular2@test.cl').id},
            {name: 'particular3', load_type: 'general', capacity: 17, driver_id: Driver.find_by( email: 'particular3@test.cl').id},
            {name: 'particular4', load_type: 'general', capacity: 17, driver_id: Driver.find_by( email: 'particular4@test.cl').id},
            {name: 'particular5', load_type: 'general', capacity: 17, driver_id: Driver.find_by( email: 'particular5@test.cl').id},
          ].each do |vehicle_params|
            vehicle = Vehicle.create(vehicle_params)
            if !vehicle.driver_id.nil?
                driver = Driver.find(vehicle.driver_id)
                driver.vehicle_id = vehicle.id
                driver.save
            end
          end

          # Routes
          [
            { starts_at: DateTime.parse('06:00:00'), ends_at: DateTime.parse('09:00:00'), load_type: 'general', cities: ['Las Condes'], stops_amount: 2, load_sum: 2},
            { starts_at: DateTime.parse('06:00:00'), ends_at: DateTime.parse('11:00:00'), load_type: 'general', cities: ['Huechuraba', 'Peñalolén', 'Ñuñoa'], stops_amount: 5, load_sum: 7},
            { starts_at: DateTime.parse('06:00:00'), ends_at: DateTime.parse('12:00:00'), load_type: 'general', cities: ['La Cisterna'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('06:00:00'), ends_at: DateTime.parse('07:00:00'), load_type: 'general', cities: ['Lo Barnechea'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('09:00:00'), ends_at: DateTime.parse('15:00:00'), load_type: 'general', cities: ['Las Condes', 'Lo Espejo', 'Lo Barnechea', 'Ñuñoa'], stops_amount: 6, load_sum: 9},
            { starts_at: DateTime.parse('09:00:00'), ends_at: DateTime.parse('12:00:00'), load_type: 'general', cities: ['Peñalolén'], stops_amount: 2, load_sum: 2},
            { starts_at: DateTime.parse('10:00:00'), ends_at: DateTime.parse('14:00:00'), load_type: 'general', cities: ['Renca', 'Conchalí', 'Providencia'], stops_amount: 3, load_sum: 5},
            { starts_at: DateTime.parse('10:00:00'), ends_at: DateTime.parse('11:00:00'), load_type: 'general', cities: ['Las Condes', 'Lo Espejo'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('12:00:00'), ends_at: DateTime.parse('13:00:00'), load_type: 'refrigerated', cities: ['Ñuñoa'], stops_amount: 1, load_sum: 1},
            { starts_at: DateTime.parse('12:00:00'), ends_at: DateTime.parse('13:00:00'), load_type: 'refrigerated', cities: ['Quinta Normal'], stops_amount: 1, load_sum: 1},
            { starts_at: DateTime.parse('12:00:00'), ends_at: DateTime.parse('14:00:00'), load_type: 'general', cities: ['Pedro Aguirre Cerda', 'La Cisterna'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('12:00:00'), ends_at: DateTime.parse('15:00:00'), load_type: 'general', cities: ['Quilicura', 'Renca', 'Providencia'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('15:00:00'), ends_at: DateTime.parse('16:00:00'), load_type: 'general', cities: ['Providencia'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('15:00:00'), ends_at: DateTime.parse('18:00:00'), load_type: 'general', cities: ['Las Condes', 'Quinta Normal'], stops_amount: 3, load_sum: 2},
            { starts_at: DateTime.parse('20:00:00'), ends_at: DateTime.parse('21:00:00'), load_type: 'general', cities: ['Las Condes', 'Lo Espejo', 'Lo Barnechea', 'Ñuñoa'], stops_amount: 10, load_sum: 9},
            { starts_at: DateTime.parse('20:00:00'), ends_at: DateTime.parse('22:00:00'), load_type: 'general', cities: ['La Pintana', 'Macul'], stops_amount: 6, load_sum: 12},
            { starts_at: DateTime.parse('20:00:00'), ends_at: DateTime.parse('23:00:00'), load_type: 'general', cities: [ 'La Florida', 'Renca', 'Qunita Normal'], stops_amount: 7, load_sum: 7},
            { starts_at: DateTime.parse('20:00:00'), ends_at: DateTime.parse('23:00:00'), load_type: 'general', cities: ['Las Condes', 'Pudahuel'], stops_amount: 2, load_sum: 2},
            { starts_at: DateTime.parse('22:00:00'), ends_at: DateTime.parse('23:00:00'), load_type: 'general', cities: ['Renca', 'Quilicura'], stops_amount: 4, load_sum: 4},
            { starts_at: DateTime.parse('22:00:00'), ends_at: DateTime.parse('23:00:00'), load_type: 'general', cities: ['Macul', 'Las Condes', 'Peñalolén', 'Pudahuel'], stops_amount: 10, load_sum: 12},
          ].each do |route_params|
            Route.create(route_params)
          end

        redirect_back fallback_location: @post
    end

    def assign
        # Separate the routes and vehicles/drivers in 2 types
        general_routes = Route.where(load_type: 'general')
        refrigerated_routes = Route.where(load_type: 'refrigerated')
        general_vehicles = Vehicle.where(load_type: 'general')
        refrigerated_vehicles = Vehicle.where(load_type: 'refrigerated')
        general_driver = Driver.where(vehicle: general_vehicles)
        refrigerated_drivers = Driver.where(load_type: 'refrigerated')
        Assignation.delete_all
        Vehicle.update_all(available_at: '2019-11-15 03:00:00')
        Driver.update_all(available_at: '2019-11-15 03:00:00')
        # Order by important parameters
        # general_routes.order(:starts_at, :load_sum, :stops_amount)
        # general_dirvers.order(:available_at, :capacity)
        general_vehicles.order(:available_at, :max_number_of_stops)        
        # Iterate routes then drivers to assign them
        available_drivers = []
        assignations = []
        general_routes.each do |route|
            available_drivers = Driver.where('available_at < ? AND max_number_of_stops >= ?', route.starts_at, route.stops_amount).order(:available_at, :max_number_of_stops)
            available_drivers.each do |driver|
                if route.cities & driver.cities == route.cities
                    if driver.vehicle_id.nil? 
                        vehicle = general_vehicles.where('available_at < ? AND capacity >= ? AND driver_id is NULL', route.starts_at, route.load_sum).order(:available_at, :capacity).first
                        if !vehicle.nil?
                            route.vehicle_id = vehicle.id
                            route.driver_id = driver.id
                            route.save
                            driver.available_at = route.ends_at
                            vehicle.available_at = route.ends_at
                            driver.save
                            vehicle.save
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
                            Assignation.create(route: route, driver: driver, vehicle: vehicle)
                            break
                        end 
                    elsif driver.vehicle.capacity >= route.load_sum && driver.vehicle.load_type == 'general'
                        route.vehicle_id = driver.vehicle_id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        driver.vehicle.available_at = route.ends_at
                        driver.save
                        driver.vehicle.save
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
                        Assignation.create(route: route, driver: driver, vehicle: driver.vehicle)
                        break
                    end
                end
            end            
        end
        refrigerated_routes.each do |route|
            available_drivers = Driver.where('available_at < ? AND max_number_of_stops >= ?', route.starts_at, route.stops_amount).order(:available_at, :max_number_of_stops)
            available_drivers.each do |driver|
                if route.cities & driver.cities == route.cities

                    if driver.vehicle_id.nil? 
                        vehicle = refrigerated_vehicles.where('available_at < ? AND capacity >= ? AND driver_id is NULL', route.starts_at, route.load_sum).order(:available_at, :capacity).first
                        if !vehicle.nil?
                            route.vehicle_id = vehicle.id
                            route.driver_id = driver.id
                            route.save
                            driver.available_at = route.ends_at
                            vehicle.available_at = route.ends_at
                            driver.save
                            vehicle.save
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
                            Assignation.create(route: route, driver: driver, vehicle: vehicle)
                            break
                        end
                    elsif driver.vehicle.capacity >= route.load_sum && driver.vehicle.load_type == 'refrigerated'
                        route.vehicle_id = driver.vehicle_id
                        route.driver_id = driver.id
                        route.save
                        driver.available_at = route.ends_at
                        driver.vehicle.available_at = route.ends_at
                        driver.save
                        driver.vehicle.save
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
                        Assignation.create(route: route, driver: driver, vehicle: driver.vehicle)
                        break
                    end
                end
            end            
        end
        p '===================================='
        p '===================================='
        p Assignation.all
        p '===================================='
        p '===================================='
        redirect_back fallback_location: @post
        # json: {
        #     assignations: assignations,
        #   }
    end
end
