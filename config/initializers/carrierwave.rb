CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket ='school-erp'
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_credentials = {
    access_key_id:     'AKIARFGOZSJ6VYK4LFXT',
    secret_access_key: '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',
    region:            'us-east-1' # Required
  }
end
