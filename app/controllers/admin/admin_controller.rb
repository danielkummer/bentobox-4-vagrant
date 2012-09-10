class Admin::AdminController < ApplicationController
  def authenticate_admin!
    #temp!!
    return true
=begin
      if current_user.admin
        return true
      end
      redirect_to root_path, :notice => "You don't have admin privileges."
      return false
=end
  end

  def index
    @validation_key_exists = AppConfiguration.where(name: AppConfiguration.defaults[:validation_key_file_name]).exists?
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
      config = AppConfiguration.find_or_create_by(name: AppConfiguration.defaults[:validation_key_file_name])
      config.value = content
      respond_to do |format|
        if config.save
          notice = 'Validation key was successfully loaded.'
        else
          notice = 'Validation key could not be saved.'
        end
        format.html { redirect_to admin_root_path, notice: notice and return }
      end
    else
    end
    redirect_to admin_root_path, notice: 'File not found'
  end

end
