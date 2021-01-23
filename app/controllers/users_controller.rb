class UsersController < ApplicationController
  skip_before_action:logged_in_user,only:[:new,:create]
  before_action :ensure_current_user, only:[:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # if @user == current_user
    # else
    #   redirect_to root_path, notice: "他者のページアクセスできません"
    # end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_current_user
    if current_user.admin == false
      if @current_user.id != params[:id].to_i
        redirect_to root_path
      end
    end
  end
end
