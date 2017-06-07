class Admin::UsersController < Admin::BaseController

  def index
    @users = User.active_users
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(active?: false) if params[:deactivate]
    redirect_to admin_users_path
  end



end
