class Public::BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks.all.page(params[:page]).per(8)
    @bookmarkcount = @bookmarks.all.count
    @game = Game.where(price: 1..1000 )#値段で絞り込む機能を実装途中
  end
  
  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.game = Game.find(params[:game_id])
    @game = Game.find(params[:game_id])
    already_bookmark = current_user.bookmarks.find_by(game_id: @bookmark.game_id)
    if already_bookmark
      flash[:notice] = "すでにブックマークしています。"
      redirect_to show_game_path(@bookmark.game.id)
    else
      @bookmark.save!
      flash[:notice] = "ブックマークしました。"
      redirect_to show_game_path(@bookmark.game.id)
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @bookmark.destroy
    redirect_to index_bookmark_path(current_user)
  end
end