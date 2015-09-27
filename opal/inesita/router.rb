module Inesita
  module Router
    include Inesita::JSHelpers
    include Inesita::Component

    attr_reader :params

    def initialize
      on_popstate method(:update!)
      on_hashchange method(:update!)
      @routes = Routes.new
      @url_params = parse_url_params
      routes
    end

    def routes; end

    def route(*params, &block)
      @routes.route(*params, &block)
    end

    def find_component
      @routes.routes.each do |route|
        if params = path.match(route[:regex])
          @params = @url_params.merge(Hash[route[:params].zip(params[1..-1])])
          return route[:component]
        end
      end
      puts 'not_found'
      @routes.routes.first
    end

    def render
      dom do
        component find_component
      end
    end

    def handle_link(path)
      push_state path
      update!
      false
    end

    def parse_url_params
      params = {}
      url_query[1..-1].split('&').each do |param|
        key, value = param.split('=')
        params[decode_uri(key)] = decode_uri(value)
      end
      params
    end
  end
end
