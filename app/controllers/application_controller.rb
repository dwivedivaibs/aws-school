class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
	before_action :url_options

	def url_options
    super
    @_url_options.dup.tap do |options|
      options[:protocol] = Rails.env.production? ? "http://" : "http://"
      options.freeze
    end
  end
end
