class Admin::GistsController < Admin::BaseController

  before_action :admin_required!	

  def index
    @gists = Gist.all
  end

  private

  def admin_required!
    redirect_to root_path unless current_user.admin?
  end    

end