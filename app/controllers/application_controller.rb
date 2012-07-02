class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "fluid"

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  before_filter :authenticate_user!

end
