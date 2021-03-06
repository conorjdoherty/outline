Outline::Application.routes.draw do
  resources :favorites do
    collection do
      post "set"
    end
  end

  resources :quick_jump_targets do
    collection do
      get "pages"
      get "projects"
    end
  end

  resources :activities

  resources :tags

  resources :todos do
    member do
      post "set_active"
    end
  end

  resources :todo_lists do
    member do
      post "move_to_page"
      post "sort_content"
    end
  end

  resources :links do
    member do
      post "move_to_page"
    end
  end

  resources :notes do
    member do
      post "move_to_page"
    end
  end

  resources :pages do
    collection do
      post "bulk_execute"
    end
    member do
      post "sort_content"
    end
  end

  resources :projects do
    collection do
      post "bulk_execute"
    end
    member do
      get "todo_lists"
    end
  end

  resources :users

  match 'dashboard' => 'domain#dashboard', :as => :dashboard
  match 'settings' => 'domain#settings', :as => :settings, :via => [:get, :put]
  match 'search' => 'domain#search', :as => :search, :via => [:get]

  # User Authentification
  resources :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'setup' => 'setup#create_first_user', :as => :setup
  match 'welcome' => 'activities#index', :as => :domain

  get "welcome/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
