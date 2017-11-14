Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/vehicles', to: 'api/vehicles#register', via: :post
  match 'vehicles/:id/locations', to: 'api/vehicles#update_location', via: :post
  match '/vehicles/:id', to: 'api/vehicles#de_register', via: :delete 
end
