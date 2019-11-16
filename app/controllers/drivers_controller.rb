def create
    p '==========================='
    p params[:driver]
    p '==========================='
    Driver.create(params[:driver])
    redirect_back fallback_location: @post
end

def delete
    Assignation.delete_all
    driver = Driver.find(params[:driver_id])
    driver.destroy
    redirect_back fallback_location: @post
end