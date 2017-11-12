Rails.application.routes.draw do
  get 'admin/show'

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end

  authenticated :user, ->(u) { u.waiting_for_approve? } do
    root to: 'visitors#wait'
  end

  authenticated :user, ->(u) { u.approved? } do
    root to: 'visitors#approved'
  end

  authenticated :user, ->(u) { u.declined? } do
    root to: 'visitors#declined'
  end
  authenticated :user, ->(u) { u.approved_soc? } do
    root to: 'visitors#approved_soc'
  end

  authenticate :user do
    get '/admin', to: 'admins#index'
    resources :users_admin, only: [] do
      member do
        get :approve
        get :ban
        get :cancel
      end
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
