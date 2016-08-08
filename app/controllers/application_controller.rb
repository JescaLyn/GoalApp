class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :errors

  def current_user
    return if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def errors
    flash[:errors] || []
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def ensure_current_user
    return if current_user
    redirect_to new_session_url
  end

  def ensure_no_current_user
    return unless current_user
    redirect_to root_url
  end
end
