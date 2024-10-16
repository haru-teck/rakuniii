Rails.application.routes.draw do
  # Deviseのルート
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    # 初回の管理者アカウント作成
    get 'users/new_admin', to: 'users/registrations#new_admin', as: :new_admin_registration
    post 'users/create_admin', to: 'users/registrations#create_admin', as: :create_admin_registration
  end

  # ログイン済みユーザーのルート（メインメニュー画面へ）
  authenticated :user do
    root to: 'main_menu#index', as: :authenticated_root
  end

  # 未ログインユーザーのルート（ログイン画面へ）
  unauthenticated do
    root to: 'users/sessions#new', as: :unauthenticated_root
  end
end









