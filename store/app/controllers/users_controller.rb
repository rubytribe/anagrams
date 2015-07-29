class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} successfully created"
      redirect_to @user
    else
      flash.now[:danger] = "user creation failed"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
