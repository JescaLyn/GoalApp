class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if current_user.goals << @goal
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    unless @goal.update(goal_params)
      flash[:errors] = @goal.errors.full_messages
    end
    redirect_to user_url(current_user)
  end

  def show
    @goal = Goal.find_by(id: params[:id])
    unless @goal
      render status: 404
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy unless @goal.nil?
    redirect_to user_url(current_user)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :visible, :completed)
  end
end
