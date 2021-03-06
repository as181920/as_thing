AsThing::Application.routes.draw do

  get "sessions/new"

  #post 'as_notes/:as_note_id/as_values/:numero' => 'as_values#update'

  resources :as_notes do
    collection do
      post :sort
      get :public
    end
    member do
      post :sort_all
      get :followers
      get :owners
      get :appliers
    end
    resources :as_labels do
      collection do
        post :sort
      end
    end
    resources :as_values
    resources :permission_requests
  end

  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users do
    collection do
      get :all
    end
    member do
      get :notes_following
      get :following
      get :followers
    end
  end
  resources :followships, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :ownerships, :only => [:destroy]

  resources :sessions, :only => [:new, :create, :destroy]

  #root :to => 'as_notes#index'
  root :to => "sessions#new"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
