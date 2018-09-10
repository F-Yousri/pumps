Rails.application.routes.draw do
  resources :pump_properties
  resources :choices
  resources :properties
  resources :pumps
  resources :decision_matrices
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
