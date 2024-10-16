Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ログイン済みユーザーのルート
  authenticated :user do
    root to: 'main_menu#index', as: :authenticated_root
  end

  # 未ログインユーザーのルート
  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end
end



