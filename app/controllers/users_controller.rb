class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You're now signed up!"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update user_params
      redirect_to root_path, notice: "Information updated!"
    else
      render :edit
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.authenticate(user_params[:password]) && @user.authenticate(user_params[:new_password]) == false
      @user.update(password: user_params[:new_password], password_confirmation: user_params[:password_confirmation])
      redirect_to root_path, notice: "Password updated!"
    else
      if @user.authenticate(user_params[:password]) == false
        flash[:alert] = "Incorrect password"
      elsif @user.authenticate(user_params[:new_password])
        flash[:alert] = "The new password should be different from the current password"
      end
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :new_password, :password_confirmation)
  end


end
