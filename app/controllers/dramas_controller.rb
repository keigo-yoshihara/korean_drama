class DramasController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @drama = Drama.new
  end
  
  def create
    @drama = current_user.dramas.build(drama_params)
    if @drama.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @pagy, @dramas = pagy(current_user.dramas.order(id: :desc))
      flash.now[:danger] = '投稿に失敗しました。'
      render 'users/dramas'
    end
  end

  def destroy
    @drama.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def drama_params
    params.require(:drama).permit(:title, :content, :rating)
  end
  
  def correct_user
    @drama = current_user.dramas.find_by(id: params[:id])
    unless @drama
      redirect_to root_url
    end
  end
end
