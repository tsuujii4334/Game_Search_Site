class Public::ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:review_id])
    @comment = Comment.new
    @comments = @review.comments.all
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.game = Game.find(params[:game_id])
    if @review.save
      redirect_to show_game_path(@review.game.id)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy
    redirect_to show_game_path(@review.game.id)
  end

  private
  def review_params
    params.require(:review).permit(:review_writing)
  end

end
#修正test