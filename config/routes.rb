Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #for signup, go to user model and create user
  post "/signup" => "users#create"
  get "/me" => "users#show"

  post "login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get "/recipes" => "recipes#index"
  post "/recipes" => "recipes#create"
end
