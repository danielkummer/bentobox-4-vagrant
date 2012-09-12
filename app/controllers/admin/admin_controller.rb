class Admin::AdminController < ApplicationController
  def authenticate_admin!
      if current_user.admin
        return true
      end
      redirect_to root_path, :notice => "You don't have admin privileges."
      return false
  end

  def index
    @app_configurations = AppConfiguration.all
  end

  def update_app_configuration
    begin
      params[:app_configuration].each do |key, value|
        AppConfiguration.where(name: key).update(value: value)
      end
      redirect_to admin_root_path, notice: 'App configuration was successfully updated.' and return
    rescue Exception
      redirect_to admin_root_path, error: 'App configuration not updated.'
    end
  end

  def load_validation_key
    filename = params[:load_validation_key][:file_path]
    if File.exists? filename
      content = File.read filename
      AppConfiguration.put('validation.pem', content)
      redirect_to admin_root_path, notice: 'Validation key was successfully loaded.' and return
    end
    redirect_to admin_root_path, notice: 'File not found'
  end

end
