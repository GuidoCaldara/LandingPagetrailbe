class UsersController < ApplicationController
  def edit_profile
    @user = current_user
  end

  def show
    @user = User.friendly.find(params[:id])
    @next_organized_runs = Run.organized_runs(@user).first(5)
    @next_runs = Run.next_runs(@user).where.not(user: @user)
  end

  def update_profile
    @user = current_user
    @user.update!(user_params)
    if @user.save
      redirect_to @user
    else
      render :edit_profile
    end
  end

  def user_params
    params.require(:user).permit(:username, :location, :avatar, :description)
  end
end
