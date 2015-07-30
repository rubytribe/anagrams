class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper

  before_action :get_time
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
