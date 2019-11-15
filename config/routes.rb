Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'routes' => 'routes#index'
  get 'routes/assign' => 'routes#assign'
end
