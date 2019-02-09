class Admin::GistsController < Admin::BaseController

  before_action :admin_required!	

  def index
    @gists = Gist.all
  end

end