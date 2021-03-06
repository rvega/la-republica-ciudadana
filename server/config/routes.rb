RepublicaCiudadana::Application.routes.draw do
  devise_scope :usuario do
    get 'usuarios/contrasena/recordar', :to=>'devise/passwords#new'
    get 'usuarios/contrasena/editar', :to=>'devise/passwords#edit'
    get 'usuarios/registrar', :to=>'registrations#new'
    get 'usuarios/registro/editar', :to=>'registrations#edit'
    get 'usuarios/salir', :to=>'sessions#destroy'
    get 'usuarios/confirmar', :to=>'devise/confirmations#show'
    get 'usuarios/confirmar/nuevo', :to=>'devise/confirmations#new'
  end
  devise_for :usuarios, 
    :controllers => {
      :sessions => 'sessions',
      :registrations => 'registrations'
    },
    :path_names => {
      :sign_in => 'ingreso', 
      :sign_out => 'salida', 
      :password => 'contrasena', 
      :registration => 'registro'
    }

  resources :usuarios
  match 'usuarios/:id(/:participacion)' => 'usuarios#show'
  resources :preguntas, :path_names => { :new => 'nueva', :edit => 'editar' }
  resources :respuestas
  resources :comentarios
  resources :votos
  match "/votos" => "votos#destroy", :via=>:delete
  root :to => 'preguntas#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
