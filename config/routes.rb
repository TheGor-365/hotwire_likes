Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    member do
      post "like",     to: "posts#like"
      delete "unlike", to: "posts#unlike"
    end
  end

  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # root action: :index, controller: "railsui/page"

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
