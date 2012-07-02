class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "fluid"
  before_filter :dummy_authentication

  def dummy_authentication
    current_user = User.first
  end
end
