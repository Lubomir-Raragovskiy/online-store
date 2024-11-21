class Admin::UsersController < ApplicationController
  class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        redirect_to admin_users_path, notice: "User deleted successfully."
      else
        redirect_to admin_users_path, alert: "Failed to delete user."
      end
    end

    private

    def authorize_admin!
      redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
    end
  end
end
