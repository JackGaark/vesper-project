Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root to: 'venue#welcome'

  resources :venue, { except: [:destroy] }
  resources :squad, { only: [:edit, :show, :update, :create] } do
  end

  post '/squad/:id/package/:package_id', to: 'squad#update_package', as: 'squad_package'
  post '/squad/:id/confirm', to: 'squad#confirm_squad_order', as: 'squad_confirm'

  post '/squad/:id/member/confirm', to: 'squad#confirm_squad_member', as: 'member_confirm'
  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
  get 'squad/:id/sidekicks', to: 'squad#add_sidekick', as: 'add_sidekick'

  get 'squad/:id/:squad_member_id/choosevenue', to: 'squad#member_choose_venue', as: 'member_choose_venue'
  post '/squad/:id/:squad_member_id/choosevenue', to: 'squad#member_confirm_venue'
  post '/squad/:id/choosevenue', to: 'squad#choose_venue_status'

  get 'squad/:id/:squad_member_id/choosecontribution', to: 'squad#member_choose_contribution', as: 'member_choose_contribution'
  post 'squad/:id/:squad_member_id/choosecontribution', to: 'squad#member_confirm_contribution'

  post 'squad/:id/squadmembers/:adding_user_id', to: 'squad#update', as: 'create_squadmember'

  get 'privacy', to: 'venue#privacy'

end
