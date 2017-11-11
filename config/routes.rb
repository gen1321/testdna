Rails.application.routes.draw do
  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end
  authenticate :user do
    root to: 'visitors#index'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
