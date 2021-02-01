class IdeasController < ApplicationController

  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  
  def new 
    @idea = Idea.new
  end

  def index 
    @ideas = Idea.all
  end

  def create 
    @idea = Idea.new idea_params
    if @idea.save
      flash[:notice] = "Idea created successfully"
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show 
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
end
