class IdeasController < ApplicationController
  
  def new 
    @idea = Idea.new
  end

  def index 
    @ideas = Idea.all
  end

  def create 
    idea_params = params.require(:idea).permit(:title, :description)
    @idea = Idea.new idea_params
    if @idea.save
      flash[:notice] = "Idea created successfully"
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show 
    @idea = Idea.find params[:id]
  end

  def edit 
    @idea = Idea.find params[:id]
  end

  def update 
    idea_params = params.require(:idea).permit(:title, :description)
    @idea = Idea.find params[:id]
    if @idea.update idea_params
      flash[:notice] = "Idea edited successfully"
      redirect_to idea_path(@idea)
    else 
      render :edit
    end
  end

  def destroy 
    @idea = Idea.find params[:id]
    @idea.destroy
    redirect_to ideas_path
  end

end
