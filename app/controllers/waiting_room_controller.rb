class WaitingRoomController < ApplicationController
  before_action :admin_redirect

  def index
  end

  private

  def admin_redirect
    redirect_to encounters_path if current_user.admin?
  end
end
