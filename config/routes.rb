Radios::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/auth" }
  match '/new', :to =>'radios#new'
  root :to => 'radios#index'
end
