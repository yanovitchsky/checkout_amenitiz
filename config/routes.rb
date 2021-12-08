require 'sidekiq/web'

Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  # if Rails.env.development?
  #   mount Sidekiq::Web => '/sidekiq'
  # else
  #   authenticate :user, lambda { |u| u.admin? } do
  #     mount Sidekiq::Web => '/sidekiq'
  #   end
  # end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products, only: %w(index)
  resources :baskets, only: %w(show create update) do
    member do
      get 'checkout'
    end
  end
  root "pages#index"
end
