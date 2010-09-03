require 'rails/railtie'

module Mongorb
  class Railtie < Rails::Railtie
    config.generators.orm :mongorb, :migration => false

    # Exposes Mongorb's configuration to the Rails application configuration.
    #
    # Example:
    #
    #   module MyApplication
    #     class Application < Rails::Application
    #       config.mongorb.logger = Logger.new($stdout, :warn)
    #       config.mongorb.reconnect_time = 10
    #     end
    #   end
    config.mongorb = ::Mongorb::Config.instance

    # Initialize Mongorb. This will look for a mongorb.yml in the config
    # directory and configure mongorb appropriately.
    #
    # Example mongorb.yml:
    #
    #   defaults: &defaults
    #     host: localhost
    #     slaves:
    #       # - host: localhost
    #         # port: 27018
    #       # - host: localhost
    #         # port: 27019
    #     allow_dynamic_fields: false
    #     parameterize_keys: false
    #     persist_in_safe_mode: false
    #
    #   development:
    #     <<: *defaults
    #     database: mongorb
    initializer "setup mongorb connection" do
      config_file = Rails.root.join("config", "database.yml")
      if config_file.file?
        settings = YAML.load(ERB.new(config_file.read).result)[Rails.env]
        Mongorb.configurate(settings) if settings.present?
      end
    end

    # After initialization we will attempt to connect to the database, if
    # we get an exception and can't find a mongorb.yml we will alert the user
    # to generate one.
    initializer "verify that mongorb is configured" do
      config.after_initialize do
        begin
          Mongorb.master
        rescue ::Mongorb::Errors::InvalidDatabase => e
          unless Rails.root.join("config", "mongorb.yml").file?
            puts "\nMongorb config not found. Create a config file at: config/mongorb.yml"
            puts "to generate one run: rails generate mongorb:config\n\n"
          end
        end
      end
    end

    # Due to all models not getting loaded and messing up inheritance queries
    # and indexing, we need to preload the models in order to address this.
    #
    # This will happen every request in development, once in ther other
    # environments.
    initializer "preload all application models" do |app|
      config.to_prepare do
        ::Rails::Mongorb.load_models(app)
      end
    end

    initializer "reconnect to master if application is preloaded" do
      config.after_initialize do

        # Unicorn clears the START_CTX when a worker is forked, so if we have
        # data in START_CTX then we know we're being preloaded. Unicorn does
        # not provide application-level hooks for executing code after the
        # process has forked, so we reconnect lazily.
        if defined?(Unicorn) && !Unicorn::HttpServer::START_CTX.empty?
          ::Mongorb.reconnect!(false)
        end

        # Passenger provides the :starting_worker_process event for executing
        # code after it has forked, so we use that and reconnect immediately.
        if defined?(PhusionPassenger)
          PhusionPassenger.on_event(:starting_worker_process) do |forked|
            if forked
              ::Mongorb.reconnect!
            end
          end
        end
      end
    end
  end
end
