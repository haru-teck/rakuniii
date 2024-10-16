class MainMenuController < ApplicationController
  before_action :authenticate_user!

  def index
    Rails.logger.debug "=== Current User: #{current_user.inspect} ==="
  end
end

