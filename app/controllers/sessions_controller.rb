class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cookies[:current_path] || root_path
    else
      redirect_to login_path, alert: 'Are you a Guru? Verify your Email and Password please'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logout!'
  end

end
