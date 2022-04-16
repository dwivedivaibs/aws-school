CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket ='school-erp'
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_credentials = {
    access_key_id:     'AKIAI5CSSKJZKKCJRQKA',
    secret_access_key: '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',
    region:            'us-east-1' # Required
  }
end
