class ToppagesController < ApplicationController
  def index
    if logged_in?
      @drama = current_user.dramas.build
    end
    @pagy, @dramas = pagy(Drama.all.order(id: :desc))
  end
end
