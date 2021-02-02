class ReviewsController < ApplicationController

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
    @review.destroy
    redirect_to idea_path(@idea)
  end

  private 

  def review_params
    params.require(:review).permit(:body)
  end
end
