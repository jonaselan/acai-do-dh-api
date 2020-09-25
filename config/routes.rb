Rails.application.routes.draw do
  resources :expenses
  resources :sales do
    collection do
      put :bunch_update
    end
  end
  resources :deliverymen do
    get :sales
    collection do
      get :with_filters
    end
  end
end
