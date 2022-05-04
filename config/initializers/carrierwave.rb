CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = Rails.application.credentials.s3_bucket_name
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_credentials = {
    access_key_id:     Rails.application.credentials.aws_access_key_id,
    secret_access_key: Rails.application.credentials.aws_secret_access_key,
    region:            Rails.application.credentials.aws_region # Required
  }
end