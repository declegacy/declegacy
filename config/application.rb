require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

BASE_URL = (Rails.env.production? || true) ? "https://app.declegacy.com" : "http://localhost:3000"

module Declegacy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    uri = URI.parse(BASE_URL)
    config.action_mailer.default_url_options = {host: uri.host, protocol: uri.scheme, port: uri.port}
    config.default_url_options = config.action_mailer.default_url_options

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
