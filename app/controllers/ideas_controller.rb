class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  
  def new 
    @idea = Idea.new
  end

  def index 
    @ideas = Idea.all
  end

  def create 
    @idea = Idea.new idea_params
    @idea.user = current_user
    
    if @idea.save
      flash[:notice] = "Idea created successfully"
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show 
    @review = Review.new
    @reviews = @idea.reviews.order(created_at: :desc)
  end

  def edit 
  end

  def update 
    if @idea.update idea_params
      flash[:notice] = "Idea edited successfully"
      redirect_to idea_path(@idea)
    else 
      render :edit
    end
  end

  def destroy 
    @idea.destroy
    redirect_to ideas_path
  end


  private 

  def find_idea 
    @idea = Idea.find params[:id]
  end

  def idea_params 
    idea_params = params.require(:idea).permit(:title, :description)
  end

  def authorize_user!
    redirect_to idea_path(@idea), alert: "Impossible Action" unless can?(:crud, @ideas)
  end

end
