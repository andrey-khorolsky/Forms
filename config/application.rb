require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(*Rails.groups)
Bundler.require(:default, Rails.env)

module Forms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators.orm = :active_record

    # config.session_store :cookie_store, key: "_interslice_session"
    config.middleware.use ActionDispatch::Cookies  # Required for all session management
    # config.middleware.use ActionDispatch::Session::CookieStore
    config.session_store :cookie_store, key: "_Forms_session_#{Rails.env}"

    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
    config.middleware.use ActionDispatch::Flash
    # config.middleware.insert_before "RescueFromInvalidAuthenticityToken", OmniAuth::Builder

    config.middleware.use ActionDispatch::Session::CacheStore
    # config.middleware.use ActionDispatch::Session::MemCacheStore
  end
end
