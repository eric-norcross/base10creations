# if Rails.env == "production"
#   # set credentials from ENV hash
#   S3_CONFIG = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "live-base10-cms"}
# else
#   # get credentials from YML file
#   S3_CONFIG = YAML.load_file(Rails.root.join('config', 'amazon_s3.yml'))[Rails.env]
# end
  

# PAPERCLIP_STORAGE_OPTIONS = {
#   s3_credentials: S3_CONFIG,
#   s3_headers: { 
#     cache_control: 'max-age=900' 
#   },
#   storage: :s3
# }