class FavoriteWorksController < ApplicationController
  before_action :set_work

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def create
    if Favorite.create(favorited: @work, user: current_user)
      redirect_to :back, notice: 'Work has been favorited'
    else
      redirect_to show_work_path(current_user.username, @work), alert: 'Something went wrong...*sad panda*'
    end
  end

  def destroy
    Favorite.where(favorited_id: @work.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Work  is no longer in favorites'
  end

  private

  def set_work
    @work = Work.find(params[:work_id] || params[:id])
  end
end
