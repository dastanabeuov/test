class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    if user.is_a?(Admin)
      admin_tests_path   
    else
      tests_path
    end
  end  

end
