class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "#{@user.name} successfully created"
      redirect_to @user
    else
      flash.now[:danger] = "user creation failed"
      render 'new'
    end
  end

  def show
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      flash[:notice] = "The user with the ID #{params[:id]} doesn't exist"
      redirect_to root_url
    end
  end

  def edit
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      flash[:notice] = "The user with the ID #{params[:id]} doesn't exist"
      redirect_to root_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash.now[:danger] = "Profile edit failed"
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully deleted"
    redirect_to users_path
  end

  private



  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  

end
