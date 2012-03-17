Radios::Application.routes.draw do

   match '/new', :to =>'radios#new'
  
   root :to => 'radios#index'
end
