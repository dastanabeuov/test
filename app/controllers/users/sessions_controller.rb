class Users::SessionsController < Devise::SessionsController

  def create
    super
    return unless @user.first_name && @user.last_name

    set_flash_message!(:notice, :logged_in, first_name: @user.first_name,
                                            last_name: @user.last_name)
  end
	
end