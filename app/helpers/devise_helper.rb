module DeviseHelper
  def devise_error_messages!
    if resource.errors.full_messages.any?
        flash.now[:danger] = resource.errors.full_messages
    end
    return ''
  end
end
