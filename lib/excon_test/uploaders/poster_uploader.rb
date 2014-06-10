class PosterUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  permissions 0600

  def store_dir
    "#{ENV["RACK_ENV"]}/posters/#{model.class.to_s.underscore}/#{model.id}"
  end

  def cache_dir
    "public/images"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def default_url
    if ENV["RACK_ENV"] == "development"
      "https://s3.amazonaws.com/test_bucket/development/images/default/default.jpg"
    else
      "#{store_dir}/default.jpg"
    end
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  version :normal do
    process :resize_to_fill => [300, 450]
  end

  version :small do
    process :resize_to_fill => [200, 300]
  end

  version :thumb do
    process :resize_to_fill => [100, 150]
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
