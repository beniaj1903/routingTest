Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'routes#index'
  get 'routes' => 'routes#index'
  get 'routes/assign' => 'routes#assign'
  get 'routes/fill_db' => 'routes#fill_db'
  post 'routes/create' => 'routes#create'
  post 'drivers/create' => 'drivers#create'
  post 'vehicles/create' => 'vehicles#create'
  post 'routes/delete' => 'routes#delete'
  post 'drivers/delete' => 'drivers#delete'
  post 'vehicles/delete' => 'vehicles#delete'
end
