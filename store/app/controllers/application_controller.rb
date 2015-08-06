class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  include SessionsHelper
  include ApplicationHelper

  before_action :get_time

  protect_from_forgery with: :exception


  private

  def correct_user(current_user)
    @product = current_user.products.find_by(id: params[:id])
    current_user.admin? || @product
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to products_path unless logged_in? && current_user.admin?
  end

  def not_found
    flash[:danger] = "#{params[:controller].chop.capitalize } not found."
    redirect_to controller: params[:controller]
  end
end
