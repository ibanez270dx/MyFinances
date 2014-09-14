require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

SECRETS = {}

module MyFinances
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Load all my App secrets
    config.before_configuration do
      path = File.join(Rails.root, 'config','secrets')
      Dir.foreach(path) do |file|
        if /\w/ =~ file
          hash = YAML.load(File.read("#{path}/#{file}")).with_indifferent_access
          SECRETS["#{file.split('.').first}".to_sym] = hash[Rails.env].symbolize_keys
        end
      end
    end

    # Add and require extensions
    config.autoload_paths += Dir[File.join(Rails.root, "lib", "extensions", "*.rb")].each {|l| require l }

    # Add Widget STI classes
    config.autoload_paths += %W(#{config.root}/app/models/widget)
  end
end
