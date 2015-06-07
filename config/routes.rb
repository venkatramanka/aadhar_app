AadharApp::Application.routes.draw do

  devise_for :stores

  devise_for :users

  resources :users, :only => [:update]
  match "users/form/:id" => "users#form"
  match "user/update/:id" => "users#update"
  match "store/update/:id" => "stores#update"
  match "user/:id" => "users#show", as: "user"
  match "store/:id" => "stores#show", as: "store"
  match "payment" => "stores#payment", as: "payment"
  match "home/transfer" => "home#transfer", as: "transfer"
  match "home/transaction" => "home#transaction", as: "do_transaction"

  get "users/index"
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
  match 'users/login' => 'users#login', :as => "login"
  match 'users/signup' => 'users#signup', :as => "registration"
  match '/store-signup' => 'stores#store_signup', :as => "store_signup"
  match '/dispatch-otp' => 'application#dispatch_otp', :as => "dispatch_otp"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

#myAadhaar : 900536202162
# https://ac.khoslalabs.com/hackgate/hackathon/otp
#   {"aadhaar-id":"900536202162","channel":"SMS", "location":{"type":"pincode", "pincode":"666666" }}

# https://ac.khoslalabs.com/hackgate/hackathon/kyc/raw
# {
#   "consent": "Y",
#   "auth-capture-request": {
#     "aadhaar-id": "900536202162",
#     "modality": "otp",
#     "otp": "352959",
#     "certificate-type": "preprod",
#     "device-id": "public",
#     "location":{
#       "type":"pincode",
#       "pincode":"620021"
#   }
# }
# }
 #x = agent.post("https://ac.khoslalabs.com/hackgate/hackathon/otp",{"aadhaar-id" => "900536202162","channel" => "SMS", "location" => {"type" => "pincode", "pincode" => "666666" }}.to_json,{'Content-Type' => 'application/json'})

#agent.post("https://ac.khoslalabs.com/hackgate/hackathon/kyc/raw",{"consent" => "Y", "auth-capture-request" => {"aadhaar-id" => "900536202162","modality" => "otp","otp" => "352959","certificate-type" => "preprod","device-id" => "public","location" => {"type" => "pincode","pincode" => "620021"}}}.to_json,{'Content-Type' => 'application/json'})
# } )
end
