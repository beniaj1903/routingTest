Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'routes' => 'routes#index'
  get 'routes/assign' => 'routes#assign'

  post 'routes/create' => 'routes#create'
  post 'driver/create' => 'driver#create'
  post 'vehicle/create' => 'vehicle#create'
  post 'routes/delete' => 'routes#delete'
  post 'driver/delete' => 'driver#delete'
  post 'vehicle/delete' => 'vehicle#delete'
end
