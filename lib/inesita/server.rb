require 'rack/rewrite'

module Inesita
  module SprocketsContext
    def asset_path(path, _options = {})
      path
    end
  end

  class Server
    attr_reader :assets_app

    def initialize
      @assets_app = create_assets_app
      @source_maps_app = create_source_maps_app
      @app = create_app
      Inesita.assets_code = assets_code
    end

    def assets_code
      assets_prefix = Inesita.env == :development ? Config::ASSETS_PREFIX : nil
      %(
        <link rel="stylesheet" type="text/css" href="#{assets_prefix}/stylesheet.css">
        #{Opal::Sprockets.javascript_include_tag('application', sprockets: @assets_app, prefix: assets_prefix, debug: Inesita.env == :development)}
       )
    end

    def create_app
      assets_app = @assets_app
      source_maps_app = @source_maps_app

      Rack::Builder.new do
        use Rack::Static, :urls => [Config::STATIC_DIR]

        use Rack::Rewrite do
          rewrite(/^(?!#{Config::ASSETS_PREFIX}|#{Config::SOURCE_MAP_PREFIX}).*/, Config::ASSETS_PREFIX)
        end

        map Config::ASSETS_PREFIX do
          run assets_app
        end

        map Config::SOURCE_MAP_PREFIX do
          run source_maps_app
        end
      end
    end

    def create_assets_app
      Opal::Server.new do |s|
        s.append_path Config::APP_DIR

        Opal.paths.each do |p|
          s.append_path p
        end

        RailsAssets.load_paths.each do |p|
          s.append_path p
        end if defined?(RailsAssets)

        configure_sprockets(s.sprockets)
      end.sprockets
    end

    def configure_sprockets(sprockets)
      sprockets.register_engine '.slim', Slim::Template
      sprockets.context_class.class_eval do
        include SprocketsContext
      end
    end

    def create_source_maps_app
      ::Opal::Sprockets::SourceMapHeaderPatch.inject!(Config::SOURCE_MAP_PREFIX)
      Opal::SourceMapServer.new(@assets_app, Config::SOURCE_MAP_PREFIX)
    end

    def call(env)
      @app.call(env)
    end
  end
end
