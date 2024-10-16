class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_admin_exists, only: [:new, :create]
  before_action :authenticate_admin!, except: [:new, :create]

  def new
    @user = User.new(role_id: 1) # 管理者のrole_idをデフォルトで設定
    super
  end

  def create
    @user = User.new(sign_up_params)
    @user.role_id = 1 # 管理者権限を付与

    if @user.save
      flash[:notice] = '管理者アカウントが作成されました。'
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  private

  def redirect_if_admin_exists
    if User.exists?(role_id: 1)
      redirect_to new_user_session_path, alert: '管理者アカウントは既に存在します。'
    end
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.role_id == 1
      redirect_to root_path, alert: '管理者のみがアクセス可能です。'
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
