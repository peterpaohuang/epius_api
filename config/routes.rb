Rails.application.routes.draw do

  devise_for :users

  namespace :api , defaults: { format: :json } do
    # We are going to list our resources here
    resources :users, :only => [:show, :create, :update, :destroy, :index]
  	resources :sessions, :only => [:create, :destroy]
  	resources :records, :only => [:show, :create, :update, :destroy, :index]

  	mount ActionCable.server => '/cable'
  end
end
