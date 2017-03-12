Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      resources :battles, except: [:index, :new, :edit, :destroy]
      resources :contests, except: [:new, :edit, :update, :destroy]
      resources :participants, only: [:create] #except: [:index, :new, :edit, :update, :destroy]
      resources :pets, except: [:new, :edit, :destroy]
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
