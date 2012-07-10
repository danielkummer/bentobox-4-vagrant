class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "fluid"

  before_filter :authenticate_user!
end
