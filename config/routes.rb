Radios::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/auth" }
  match '/new', :to =>'radios#new'
  match '/like', :to => 'radios#like'
  match '/favicon.ico' :to => '/assets/favicon.ico'
  
  root :to => 'radios#index'
end
