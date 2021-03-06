Rails.application.routes.draw do
  root "landing_pages#index"

  get "/get_synonyms/:word" => "posts#get_synonyms"

  namespace :admin do
    resources :prompts
  end

  resources :users, path: "writers"
  get "/welcome" => "users#welcome"
  get "/profile" => "users#show"
  get "/writers/:id/stats" => "users#stats", as: :stats

  resources :posts, except: [:edit]
  get "/write" => "posts#edit", as: :write
  post "/publish/:post_id" => "posts#publish", as: :publish
  post "/unpublish/:post_id" => "posts#unpublish", as: :unpublish
  get "/refresh_random_prompt" => "posts#refresh_random_prompt"

  resources :comments, only: [:create]

  resources :archive, only: [:index]
  get "/download" => "archive#download", as: :download

  resources :landing_pages

  get "/login" => "sessions#new", as: :login
  post "/login" => "sessions#create"
  post "/logout" => "sessions#destroy", as: :logout

  resources :password_resets
  resources :subscriptions
  delete "/destroy_subscription" => "subscriptions#destroy",
    as: :destroy_subscription
  resources :refunds, only: [:create]
end
