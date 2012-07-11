CarrierWave.configure do |config|

  config.root = Rails.root.join('tmp')
  config.cache_dir = "uploads"

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

  if Rails.env.production?
    config.s3_access_key_id = ENV['s3_access_key_id']
    config.s3_secret_access_key = ENV['s3_secret_access_key']
    config.s3_bucket = ENV['s3_bucket']   #bentobox-4-vagrant
  end

  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  end
end