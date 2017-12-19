# ApplicationController is inherited by other controillers in this system
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :authenticate_user!  # devise

  GENERIC_FORM_ERROR_FLASH = 'Please correct errors below and re-submit.'
end
