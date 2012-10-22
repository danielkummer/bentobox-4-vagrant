# encoding: utf-8

class VagrantboxUploader < CarrierWave::Uploader::Base
  permissions 0777

  storage :file

  #use for storage on heroku
  #storage :fog

  def store_dir
    "public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(box)
  end

  def move_to_store
    true
  end

  def move_to_cache
    true
  end

end
