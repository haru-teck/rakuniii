class Users::SessionsController < Devise::SessionsController
  # GET /users/sign_in
  def new
    Rails.logger.debug "=== Params in new action: #{params.inspect} ==="
    super  # newアクションはフォームを表示するだけ
  end

  # POST /users/sign_in
  def create
    Rails.logger.debug "=== Params in create action: #{params.inspect} ==="

    user = User.find_by(name: sign_in_params[:name])

    if user&.valid_password?(sign_in_params[:password])
      sign_in(user)
      redirect_to authenticated_root_path, notice: 'ログインしました。'
    else
      flash.now[:alert] = '名前またはパスワードが正しくありません。'
      render :new, status: :unauthorized
    end
  end

  private

  # nameとpasswordのパラメータのみを許可
  def sign_in_params
    # パラメータがない場合にエラーを避けるための対策
    params.fetch(:user, {}).permit(:name, :password)
  end
end


