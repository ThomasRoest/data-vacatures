require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ihmnetwork
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.autoload_paths += %W( #{config.root}/app/services )

    config.time_zone = 'Amsterdam'
        
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :nl
    I18n.available_locales = [:nl, :en]
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif epiceditor.css epic-light.css epic-preview.css)
   
     # config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/mailer_previews"
    
    config.generators do |g|
     g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
     g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
