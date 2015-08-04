class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to signup_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile successfully updated"
      redirect_to user_path(@user)
    else 
      flash[:notice]  = "Please update again"
      redirect_to edit_user_path(@user)
    end
  end

 #  def update
 #   @user = User.find(params[:id])
 #   if @user.update_attributes(user_params)
 #     # Handle a successful update.
 #   else
 #     render 'edit'
 #   end
 # end

  def show
    @user = User.find(params[:id])
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
