class SessionsController < ApplicationController
  before_action :ensure_no_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])

    if @user
      login!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
