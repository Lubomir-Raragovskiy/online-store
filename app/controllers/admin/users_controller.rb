class Admin::UsersController < Admin::SessionController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.all
  end


  def show
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User created successfully."
    else
      render :new, alert: "Failed to create user."
    end
  end


  def edit
  end


  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User updated successfully."
    else
      render :edit, alert: "Failed to update user."
    end
  end


  def destroy
    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete yourself."
    elsif @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: "Failed to delete user."
    end
  end

  private


  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
