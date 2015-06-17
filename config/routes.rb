Ihmnetwork::Application.routes.draw do

localized do 

  resources :users, except: [:new] do 
    member do 
      get :following, :followers
      get :mijn_vacatures
    end
  end

  resources :topics do
    member do
      get :topic_following, :topic_followers
    end
  end

  resources :jobs, except: [:new] 
  resources :jobapplications, only: [:new, :index, :create, :show]
  resources :courses

end
  
  match 'nieuwe-vacature/:guid', to: 'jobs#new',       via: 'get', as: :newjob


  match 'gratis-vacature/:guid',      to: 'jobs#new_free',          via: 'get',     as: :freejob
  match 'gratis-vacature/:guid',      to: 'jobs#create_free',       via: 'post',    as: :create_freejob
  match 'gratis-vacature-plaatsen',   to: 'static_pages#new_free',  via: 'get',     as: :free_subscription_page

  
  localized do 
    resources :posts, only:       [:new, :show, :index, :create, :edit, :update, :destroy] do 
      resources :comments
    end
  end

  resources :sessions, only:    [:new, :create, :destroy]
  resources :account_activations, only: [:new, :create, :edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :toprelations, only: [:create, :destroy]
  resources :contacts, only: [:create]
  resources :products
  resources :stripe_events, only: [:create]
 

  localized do 
    resources :subscriptions, only: [:index, :new, :create, :destroy]
    resources :free_subscriptions, only: [:new]
  end
  
  root 'static_pages#home'

  # get 'nieuws'              => 'static_pages#home',    as: :news
  get 'registreren'         => 'users#new',            as: :signup
  #sessions
  get   'aanmelden'         => 'sessions#new',         as: :signin
  post  'aanmelden'         => 'sessions#new' 
  delete 'signout'          => 'sessions#destroy'
  #static
  get 'over-datavacature'   => 'static_pages#about',   as: :about
  get 'help'                => 'static_pages#help'
  get 'contact'             => 'contacts#new'
  get 'privacycookies'      => 'static_pages#pc_statement'
  get 'vragen'              => 'static_pages#faq'

  #subscriptions
  get     '/subscriptions/overview'        => 'subscriptions#overview',        as: :overview
  get     'subscriptions/overview/show'    => 'subscriptions#show_sub',        as: :showsub
  get     'subscriptions/multiple/new'     => 'subscriptions#show_multiple',   as: :show_multiple
  post    'subscriptions/multiple/new'     => 'subscriptions#create_multiple'

  delete  'delete_card'                    => 'users#delete_card'
  get     'updatecard'                     => 'users#update_card'

  get     'search'                         => 'posts#search',                  as: :search

  mount StripeEvent::Engine => '/stripe-events'
end

