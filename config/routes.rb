Lunch::Application.routes.draw do
  match 'user/reset_pwd/:id' => 'users#reset_pwd', :via => :get, :as => :user_resetpwd
  match 'user/:id' => 'users#add_money', :via => :post, :as => :user_money
  match 'user/:id' => 'users#add_money_form', :via => :get, :as => :user_money
  match 'user/spend_money/:id' => 'users#spend_money', :via => :post, :as => :user_spend_money
  match 'user/spend_money/:id' => 'users#spend_money_form', :via => :get, :as => :user_spend_money
  match 'user/history/:id' => 'users#history', :via => :get, :as => :user_history
  match 'user/profile/:id' => 'users#profile', :via => :get, :as => :user_profile
  match 'user/profile/:id' => 'users#profile_update', :via => :put, :as => :user_profile
  devise_for :users

  match 'foods' => 'foods#destroy_many', :via => :delete, :as => :foods
  match 'foods/:id/users' => 'foods#order_users', :as => :foods_order_users
  resources :foods
  match 'orders' => 'orders#create_many', :via => :post, :as => :orders
  match 'order/:food_id' => 'orders#create', :via => :post, :as => :new_order
  resources :orders, :only => [:destroy]
  get "home/index"
  match 'faq' => 'home#faq', :via => :get, :as => :faq
  match 'stat' => 'home#stat', :via => :get, :as => :stat
  match 'user_stat' => 'home#user_stat', :via => :get, :as => :user_stat
  match 'system/timezone' => 'home#timezone', :via => :get, :as => :sys_timezone
  match 'system/check' => 'home#check_sys', :via => :post, :as => :sys_check
  match 'system/setup' => 'home#sys_setup', :via => :post, :as => :sys_setup
  match 'system/:flag' => 'home#system', :via => :get, :as => :system

  match 'shop/hide/:id' => 'shops#hide', :via => :get, :as => :shop_hide
  resources :shops, :only => [:new, :create, :destroy, :show]

  match 'update' => 'update#update', :via => :get, :as => :update
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
