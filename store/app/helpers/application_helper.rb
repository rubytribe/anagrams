module ApplicationHelper
  def get_time
    @time = Time.now
    @time = @time.strftime("%I:%M%p %d/%m/%Y")
  end
end
