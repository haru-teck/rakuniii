class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!, except: [:new, :create, :new_admin, :create_admin]
  before_action :redirect_if_admin_exists, only: [:new_admin, :create_admin]

  # 初回管理者アカウント作成用アクション
  def new_admin
    @user = User.new(role_id: 1) # デフォルトで管理者
  end

  def create_admin
    @user = User.new(sign_up_params)
    @user.role_id = 1 # 管理者権限を強制的に付与

    if @user.save
      flash[:notice] = '管理者アカウントが作成されました。'
      redirect_to authenticated_root_path
    else
      render :new_admin
    end
  end

  # 通常のユーザー作成用アクション
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = '新しいユーザーが作成されました。'
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  private

  def authenticate_admin!
    unless user_signed_in? && current_user.role_id == 1
      redirect_to unauthenticated_root_path, alert: '管理者のみがアクセス可能です。'
    end
  end

  def redirect_if_admin_exists
    if User.exists?(role_id: 1)
      redirect_to new_user_session_path, alert: '管理者は既に存在します。'
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :role_id)
  end
end
