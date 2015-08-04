class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :myproducts]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @feed_items = []
    if logged_in?
      if(current_user?(@user))
        @product = current_user.products.build
        @feed_items = current_user.feed.paginate(page: params[:page])
      else
        @product = @user.products.build
        @feed_items = @user.feed.paginate(page: params[:page])
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Pawn Shop!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def myproducts
    @user = current_user
    if logged_in?
      @product = current_user.products.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end


  private

      def user_params
        params.require(:user).permit(:name, :email,
                                     :password, :password_confirmation, :picture)
      end

      # before filters

      # confirms the correct user
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      # confirms an admin user
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

end
