Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :users, param: :_username
    post '/auth/login', to: 'authentication#login'
    
    resources :pokemons
  end
end
