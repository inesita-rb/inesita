module Inesita
  module Router
    include Inesita::JSHelpers
    include Inesita::Component

    attr_reader :params

    def initialize
      on_popstate method(:update_dom)
      on_hashchange method(:update_dom)
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
          @component_props = route[:component_props]
          return route[:component]
        end
      end
      fail 'not_found'
    end

    def render
      dom do
        component find_component, props: @component_props
      end
    end

    def handle_link(path)
      push_state path
      update_dom
      false
    end

    def parse_url_params
      params = {}
      url_query[1..-1].split('&').each do |param|
        key, value = param.split('=')
        params[decode_uri(key)] = decode_uri(value)
      end unless url_query.length == 0
      params
    end

    def url_for(name)
      route = case name
              when String
                @routes.routes.find { |route| route[:name] == name }
              when Object
                @routes.routes.find { |route| route[:component] == name }
              end
      if route
        route[:path]
      else
        raise "Route '#{name}' not found."
      end
    end
  end
end
