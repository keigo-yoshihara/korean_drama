class ToppagesController < ApplicationController
  def index
    @pagy, @dramas = pagy(current_user.dramas.order(id: :desc))
  end
end
