CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'uploads'


  # S3 doesn't allow for "+" or "-"...
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.]/

  config.storage = :fog
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region => 'eu-west-1'
  }
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_public = false
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'} # optional, defaults to {}


  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  end

end