class HomeController < ApplicationController
  def index
    if User.exists?(role_id: 1)  # role_id: 1 は管理者
      redirect_to new_user_session_path  # すでに管理者がいる場合は通常のログイン画面へ
    else
      redirect_to new_admin_registration_path  # 管理者がいない場合は管理者作成画面へ
    end
  end
end


