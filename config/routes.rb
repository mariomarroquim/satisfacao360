Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :update, :destroy]
  resources :questions, only: [:index, :create, :edit, :update, :destroy]

  # get 'backend/start' => 'backend#start'
  get 'backend/index' => 'backend#index'

  get 'backend/answers_by_result'              => 'backend#answers_by_result'
  get 'backend/answers_by_question_and_result' => 'backend#answers_by_question_and_result'
  get 'backend/answers_by_result_and_month'    => 'backend#answers_by_result_and_month'

  get 'users/publish'   => 'users#publish'
  get 'users/unpublish' => 'users#unpublish'

  get  'questionarios/:slug'         => 'answers#new',    as: "view_questionaire"
  post 'questionarios/:slug/create'  => 'answers#create', as: "save_questionaire"
  get  'questionarios/:slug/success' => 'answers#show',   as: "finish_questionaire"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'backend#start'

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
