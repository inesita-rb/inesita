module Inesita
  module_function

  def server
    Rack::Builder.new do
      sprockets = Sprockets::Environment.new.tap do |s|
        # register engines
        s.register_engine '.slim', Slim::Template
        s.register_engine '.rb', Opal::Processor

        # add folders
        s.append_path 'app'

        # add paths from opal
        Opal.paths.each do |p|
          s.append_path p
        end

        # add paths from rails-assets
        RailsAssets.load_paths.each do |p|
          s.append_path p
        end

        s.context_class.class_eval do
          def asset_path(path, options = {})
            "#{path}"
          end
        end
      end

      if Opal::Processor.source_map_enabled
        source_maps_prefix =  '/__OPAL_MAPS__'
        source_maps = Opal::SourceMapServer.new(sprockets, source_maps_prefix)
        ::Opal::Sprockets::SourceMapHeaderPatch.inject!(source_maps_prefix)

        map source_maps_prefix do
          run source_maps
        end
      end

      $LOAD_ASSETS_CODE = Opal::Processor.load_asset_code(sprockets, 'application')
      $SCRIPT_FILES = (sprockets['application'].dependencies + [sprockets['application.self']]).map(&:logical_path)

      map '/' do
        run sprockets
      end
    end
  end
end
