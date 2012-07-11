CarrierWave.configure do |config|

  config.root = Rails.root.join('tmp')
  config.cache_dir = "uploads"
  #config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.storage = :fog
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public     = false     # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

=begin not supported by the carrierwave-mongoid gem at the moment
  config.storage = :grid_fs
  config.grid_fs_access_url = '/gridfs'

  config.grid_fs_connection = Mongoid.database

  if Rails.env.production?
    uri = URI.parse(ENV['MONGOHQ_URL'])
    config.grid_fs_database = File.basename(uri.path)
    config.grid_fs_host = uri.host unless uri.host.blank?
    config.grid_fs_port = uri.port unless uri.port.blank?
    config.grid_fs_username = uri.user unless uri.user.blank?
    config.grid_fs_password = uri.password unless uri.password.blank?
  end
=end


  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  end
end