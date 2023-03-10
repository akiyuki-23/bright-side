Rails.application.routes.draw do
  root to: "good_founds#index"
  devise_for :users
  resources :good_founds, only: [:index, :new, :create, :show, :edit, :update] do
    resources :comments, only: [:create, :destroy]
  end
end
