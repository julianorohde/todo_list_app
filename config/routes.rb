Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "todos#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :todos
end
