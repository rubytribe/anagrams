class ApplicationController < ActionController::Base
  before_action :get_time
  def get_time
    @time = Time.now
    @time = @time.strftime("%I:%M%p %d/%m/%Y")
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
