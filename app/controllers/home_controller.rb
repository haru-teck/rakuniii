class HomeController < ApplicationController
  def index
    # 管理者がいない場合、管理者登録画面にリダイレクト
    if User.where(role_id: 1).empty?
      redirect_to new_user_registration_path, alert: '管理者アカウントを作成してください。'
    else
      redirect_to new_user_session_path
    end
  end
end


