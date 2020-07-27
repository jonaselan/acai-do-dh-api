Rails.application.routes.draw do
  resources :expenses
  resources :sales
  resources :deliverymen
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
