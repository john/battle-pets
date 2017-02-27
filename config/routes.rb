Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # devise_scope :user do
      #   post '/sessions/create', to: '/api/v1/sessions#create'
      # end

      devise_for :users, controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      } #, path_names: { sign_in: 'create', sign_out: 'destroy'}

      # resources :contests, except: [:new, :edit]  do
      #   resources :pets, except: [:new, :edit]
      # end

      # TODO: remove exception on :update, if you ever implement
      resources :contests, except: [:new, :edit, :update]
      resources :pets, except: [:new, :edit, :update]
      resources :battles #, except: [:index, :new, :edit, :update]
      resources :participants, except: [:index, :new, :edit, :update]

    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
