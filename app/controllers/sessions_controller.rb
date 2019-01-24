class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to request_page || root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logout!'
  end

  private

  def request_page
    return cookies[:current_path] if cookies[:current_path]
    root_path
  end

end
