Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'decision_maker#techEvalForm'
  get '/', to: 'decision_maker#techEvalForm', as: 'techEvalForm'
  post '/', to: 'decision_maker#techEval', as: 'techEval'
  post '/test' ,to: 'decision_maker#phaseTwoPump1'
  post '/test2' ,to: 'decision_maker#phaseTwoPump2'
  post '/test3' ,to: 'decision_maker#phaseTwoPump3'
  post '/test4' ,to: 'decision_maker#phaseTwoPump4'


end
