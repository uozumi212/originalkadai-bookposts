Rails.application.routes.draw do
    root to:"toppages#index"
    
   
    
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    get "bookposts/new", to: "bookposts#new"
   
    get "signup", to: "users#new"
     
    resources :users, only: [:index, :show, :new, :create, :destroy] do 
        member do
           get :likes
       end
    end
   
    resources :bookposts, only: [:index, :show, :new, :create, :destroy] 
    resources :likes, only: [:create, :destroy]
end
