if Rails.env == "production"
  # set credentials from ENV hash
  S3_CONFIG = { 
    :aws_access_key_id      => ENV['S3_KEY'], 
    :aws_secret_access_key  => ENV['S3_SECRET'], 
    :bucket                 => "live-martinfurniture"
  }
else
  S3_CONFIG = YAML.load_file(Rails.root.join('config', 'amazon_s3.yml'))[Rails.env]
  S3_CONFIG.symbolize_keys!
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => S3_CONFIG[:aws_access_key_id],                # required
    :aws_secret_access_key  => S3_CONFIG[:aws_secret_access_key]             # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory = S3_CONFIG[:bucket]                     # required
  # config.fog_public     = false                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

  # STDOUT << "3: #{config.fog_credentials[:aws_access_key_id]}"
end