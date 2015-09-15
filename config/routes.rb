Rails.application.routes.draw do
  get 'home/index'

  get 'sync_status' => "sync_status#index", as: :sync_status

  resources :results, except: [:edit, :new]
  resources :search_tasks
  resources :rss_feeds do
    get 'rss', on: :member, format: 'xml'
    get 'atom', on: :member, format: 'atom'
  end
  resources :feed_urls do
    get 'rss', on: :member, format: 'xml'
    get 'atom', on: :member, format: 'atom'
  end

  resources :searches do
    get 'provider_form', on: :collection
    get 'run', on: :member
    resources :search_tasks
  end
  devise_for :accounts

  root 'home#index'

  require 'sidekiq/web'
  authenticate :account, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
