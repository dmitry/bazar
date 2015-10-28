Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'
  resources :items, only: :show do
    resource :enquiry, only: :create
  end
end
