Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

      devise_scope :user do
        post '/sessions/create', to: '/api/v1/sessions#create'
      end

      devise_for :users, controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      } #, path_names: { sign_in: 'create', sign_out: 'destroy'}

      resources :contests do
        resources :pets
      end
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
