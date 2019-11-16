def create
    Driver.create(params[:vehicle])
    redirect_back fallback_location: @post
end

def delete
    Assignation.delete_all
    vehicle = Vehicle.find(params[:vehicle_id])
    vehicle.destroy
    redirect_back fallback_location: @post
end