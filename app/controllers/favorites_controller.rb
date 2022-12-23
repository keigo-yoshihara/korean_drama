class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    drama = Drama.find(params[:drama_id])
    current_user.favorite(drama)
    flash[:success] = 'このドラマをを観たいリストに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    drama = Drama.find(params[:drama_id])
    current_user.unfavorite(drama)
    flash[:success] = '観たいリストから削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
