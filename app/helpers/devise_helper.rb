module DeviseHelper
  def devise_error_messages!
    if resource.present?
      messages = resource.errors.full_messages.map { |msg| "setTimeout(function(){z_.alert({type :'warning',message:'#{msg}'});},100);" }.join

      messages.html_safe
    else
      return ""
    end
  end

  def resource
    @soon_user ||= SoonUser.new
    @user ||= User.new
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end