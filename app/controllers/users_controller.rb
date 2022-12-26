class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:fav_dramas, :likes, :destroy]

  def show
    @user = User.find(params[:id])
    @pagy, @dramas = pagy(@user.dramas.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_to root_url
  end
  
  def fav_dramas
    @user = User.find(params[:id])
    @pagy, @fav_dramas = pagy(@user.fav_dramas)
  end
  
  def likes
    @user = User.find(params[:id])
    @pagy, @fav_dramas = pagy(@user.fav_dramas)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
