class ApplicationController < ActionController::Base
  before_action :logged_in_user

  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインして下さい"
      redirect_to new_session_path
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
