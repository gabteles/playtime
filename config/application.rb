require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Playtime
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Prevent generators from creating empty stylesheets we won't use
    config.generators do |g|
      g.stylesheets     false
    end

    # Webconsole config with docker (enabled in development only)
    if Rails.env.development? && ENV['DOCKER_DEV'] && config.respond_to?(:web_console)
      # Finds container's private IP and allowed network
      private_ip = Socket.ip_address_list.find(&:ipv4_private?).ip_address
      allowed_network = "#{private_ip}/24"
      # Add network range to WebConsole whithelist
      config.web_console.whitelisted_ips.push(allowed_network)
    end
  end
end
