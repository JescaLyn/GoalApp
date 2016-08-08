class SessionsController < ApplicationController
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
end
