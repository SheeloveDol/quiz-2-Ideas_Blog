class ReviewsController < ApplicationController

    before_action :authenticate_user!

  def create 
    @idea = Idea.find params[:idea_id]
    @review = Review.new review_params
    @review.idea = @idea
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review successfully created"
      redirect_to idea_path(@idea)
    else
      redirect_to idea_path(@idea)
    end

  end

  def destroy 
    @idea = Idea.find params[:idea_id]
    @review = Review.find params[:id]
    if can?(:crud, @review)
      @review.destroy
      redirect_to idea_path(@idea), notice: 'Review deleted'
    else 
      redirect_to idea_path(@idea), alert: "Oops! Can't do that"
    end
  end

  private 

  def review_params
    params.require(:review).permit(:body)
  end
end
