class Users::SessionsController < Devise::SessionsController

  def create
    super
    set_flash_message!(:notice, :logged_in, full_name: @user.full_name) unless @user.full_name.blank?
  end

end