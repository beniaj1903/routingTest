Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'routes' => 'routes#index'
  get 'routes/assign' => 'routes#assign'
  
  post 'routes/create' => 'routes#create'
  post 'routes/delete_driver' => 'routes#delete_driver'
  post 'routes/delete_vehicle' => 'routes#delete_vehicle'
  post 'routes/delete_route' => 'routes#delete_route'
end
