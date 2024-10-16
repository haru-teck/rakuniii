class MainMenuController < ApplicationController
  before_action :authenticate_user!  # ログインしているユーザーのみアクセス可能

  def index
    # 必要に応じて、ここに処理を追加
  end
end

