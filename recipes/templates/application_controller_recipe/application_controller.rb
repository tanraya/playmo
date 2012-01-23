class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, :with => :handle_exceptions

  before_filter :set_current_user

protected

  def set_current_user
    User.current = current_user
  end

  def not_found!
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  def handle_exceptions(e)
    case e
    #when CanCan::AccessDenied
    when ActiveRecord::RecordNotFound
      not_found
    else
      internal_error(e)
    end
  end

  def not_found
    # Just render view
    render 'application/not_found', :status => 404
  end

  def internal_error(exception)
    if Rails.env.production?

      # Uncomment this if you want to use ExceptionNotifier
      # Send message to admin email via exception_notification
      # request.env['exception_notifier.options'] = {
      #  :sender_address       => "noreply@example.ru",
      #  :exception_recipients => "johndoe@example.com"
      # }

      # ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver

      # And just render view
      render :layout   => 'layouts/application',
              :template => 'application/internal_error',
              :status   => 500
    else
      raise
    end
  end
end

