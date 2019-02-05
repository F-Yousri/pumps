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
  post '/phasethree',to: 'decision_maker#phasethree'
  post '/phasethree1' , to: 'decision_maker#phasethreepump1'
  post '/phasethree2' , to: 'decision_maker#phasethreepump2'
  post '/phasethree3' , to: 'decision_maker#phasethreepump3'
  post '/phasethree4' , to: 'decision_maker#phasethreepump4'
  get '/pump2' , to: 'decision_maker#showpumps'




end
