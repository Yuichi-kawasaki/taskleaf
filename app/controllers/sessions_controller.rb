class SessionsController < ApplicationController
skip_before_action:logged_in_user

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path(user.id)
   else
     flash.now[:danger] = 'ログインに失敗しました'
     render :new
   end
 end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
