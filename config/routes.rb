Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Like routes
  get 'likes/add_like', to: 'like#addLike', as: :addLike
  delete 'likes/remove_like', to: 'like#removeLike', as: :removeLike

  # Authentication routes
  post 'auth/login', to: 'auth#login'
  post 'auth/register', to: 'auth#register'

  # Defines the root path route ("/")
  # root "posts#index"
end
