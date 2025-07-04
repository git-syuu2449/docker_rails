require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])

    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja, :en]

    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    # 各ディレクトリに配置したi18nを読み込む。明示的に記載
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]

    # autoload/eager_load
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    # generatorカスタマイズ
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.helper false
      g.assets false
      g.view_specs false
      g.controller_specs false
    end

    # Asset pipeline
    config.assets.enabled = true

  end
end
