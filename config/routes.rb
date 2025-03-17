Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication routes
  post 'auth/login', to: 'auth#login'
  post 'auth/register', to: 'auth#register'

  # Question routes
  post 'question/create', to: 'question#create_question'
  get 'question/get/questions', to: 'question#get_questions'
  # Defines the root path route ("/")
  # root "posts#index"
end
