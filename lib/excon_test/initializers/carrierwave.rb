if ENV["RACK_ENV"] == "test"
  CarrierWave.configure do |config|
    config.storage           = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.root            = "#{Dir.pwd}/public/images"
    config.storage         = :fog
    config.fog_directory   = "test_bucket"
    config.fog_public      = true
    config.fog_attributes  = {'Cache-Control' => 'max-age = 315576000'}
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => 'ACCESS_KEY',
      :aws_secret_access_key => 'SECRET'
    }
  end
end
