module Inesita
  class Builder
    def initialize(app)
      @app = app
    end

    def fetch(url)
      response(URI.parse(url)).body.reduce('') do |content, element|
        content += element
      end
    end

    private

    def response(uri)
      status, headers, body = @app.call({
        'HTTP_HOST' => @host,
        'PATH_INFO' => uri.path,
        'QUERY_STRING' => uri.query || '',
        'rack.url_scheme' => 'http',
        'REQUEST_METHOD' => 'GET',
        'SCRIPT_NAME' => '',
        'SERVER_NAME' => uri.host
      })

      ::Rack::Response.new(body, status, headers)
    end
  end
end
