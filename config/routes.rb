Rails.application.routes.draw do
  resources :expenses
  resources :sales
  resources :deliverymen do
    get :sales
  end
end
