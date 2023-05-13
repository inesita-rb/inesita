module Inesita
  class Server
    def initialize(*args, &block)
      server = server(*args, &block)

      @rack = Rack::Builder.new do
        use Rack::Static, urls: [Inesita::Config::STATIC_DIR]
        run server
      end

      Opal.append_path 'app'
      Inesita.assets_code = assets_code
    end

    def call(*args)
      @rack.call(*args)
    end

    def assets_code(path = 'application')
      @server.javascript_include_tag(path)
    end

    def server(*args, &block)
      @server = if block_given?
                  Opal::SimpleServer.new(*args, &block)
                else
                  Opal::SimpleServer.new(*args) do |server|
                    server.main = ::Inesita::Config::SERVER_MAIN
                    server.index_path = ::Inesita::Config::SERVER_INDEX_PATH
                  end
                end
    end
  end
end
