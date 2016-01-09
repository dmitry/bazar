Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '(:locale)', constraints: {locale: /#{I18n.available_locales.map(&:to_s).join('|')}/} do
    root 'home#index'
    resources :items, only: [:index, :new, :show, :create] do
      collection do
        resources :photos, only: [:create, :destroy]
      end
      resources :photos, only: [:create, :destroy]
      resource :enquiry, only: :create
    end
  end
end
