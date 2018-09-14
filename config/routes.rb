Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'decision_maker#techEvalForm'
  get '/', to: 'decision_maker#techEvalForm', as: 'techEvalForm'
end
