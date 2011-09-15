class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user

private
  def set_current_user
    User.current = current_user
  end
end
