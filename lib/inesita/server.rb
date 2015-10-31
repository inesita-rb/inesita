require 'rack/rewrite'

module Inesita
  class Server
    SOURCE_MAP_PREFIX = '/__OPAL_MAPS__'
    ASSETS_PREFIX = '/__ASSETS__'

    attr_reader :assets_app

    def initialize
      @assets_app = create_assets_app
      @source_maps_app = create_source_maps_app
      @app = create_app
      Inesita.assets_code = assets_code
    end

    def assets_code
      assets_prefix = Inesita.env == :development ? ASSETS_PREFIX : nil
      %{
      <link rel="stylesheet" type="text/css" href="#{assets_prefix}/stylesheet.css">
      #{Opal::Sprockets.javascript_include_tag('application', sprockets: @assets_app, prefix: assets_prefix, debug: Inesita.env == :development)}
      }
    end

    def create_app
      assets_app = @assets_app
      source_maps_app = @source_maps_app

      Rack::Builder.new do
        use Rack::Rewrite do
          rewrite %r[^(?!#{ASSETS_PREFIX}|#{SOURCE_MAP_PREFIX}).*], ASSETS_PREFIX
        end

        map ASSETS_PREFIX do
          run assets_app
        end

        map SOURCE_MAP_PREFIX do
          run source_maps_app
        end
      end
    end

    def create_assets_app
      Sprockets::Environment.new.tap do |s|
        s.register_engine '.slim', Slim::Template
        s.register_engine '.rb', Opal::Processor

        s.append_path 'app'

        Opal.paths.each do |p|
          s.append_path p
        end

        RailsAssets.load_paths.each do |p|
          s.append_path p
        end if defined?(RailsAssets)

        s.context_class.class_eval do
          def asset_path(path, options = {})
            path
          end
        end
      end
    end

    def create_source_maps_app
      ::Opal::Sprockets::SourceMapHeaderPatch.inject!(SOURCE_MAP_PREFIX)
      Opal::SourceMapServer.new(@assets_app, SOURCE_MAP_PREFIX)
    end

    def call(env)
      @app.call(env)
    end
  end
end
