Rails.application.routes.draw do

  get '/get_user', to: 'users#get_user'
  devise_for :users,
    path: '',
    path_names: {
     sign_in: 'login',
     sign_out: 'logout',
     registration: 'signup'
    },
    controllers: {
     sessions: 'sessions',
     registrations: 'registrations'
    }

    resources :companies do
      resources :cash_mangments
    end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
