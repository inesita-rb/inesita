module Inesita
  module Router
    include Inesita::Component

    attr_reader :params

    def initialize
      @routes = Routes.new
      fail Error, 'Add #routes method to router!' unless respond_to?(:routes)
      routes
      fail Error, 'Add #route to your #routes method!' if @routes.routes.empty?
      find_route
      parse_url_params
      add_listeners
    end

    def add_listeners
      $window.on(:popstate) { render! }
      $window.on(:hashchange) { render! }
    end

    def route(*params, &block)
      @routes.route(*params, &block)
    end

    def find_route
      @routes.routes.each do |route|
        next unless path.match(route[:regex])
        return go_to(url_for(route[:redirect_to])) if route[:redirect_to]
        return @route = route
      end
      fail Error, "Can't find route for url"
    end

    def find_component(route)
      @component_props = route[:component_props]
      route[:component]
    end

    def render
      if @route
        component find_component(@route), props: @component_props
      end
    end

    def go_to(path)
      $window.history.push(path)
      find_route
      parse_url_params
      render!
      false
    end

    def parse_url_params
      @params = {}
      url_query = $window.location.query.to_s
      url_query[1..-1].split('&').each do |param|
        key, value = param.split('=')
        params[key.decode_uri_component] = value.decode_uri_component
      end unless url_query.length == 0
      @route ? @params.merge(Hash[@route[:params].zip(path.match(@route[:regex])[1..-1])]) : @route
    end

    def url_for(name, params = nil)
      route = @routes.routes.find do |r|
        case name
        when String
          r[:name] == name || r[:path] == name
        when Object
          r[:component] == name
        else
          false
        end
      end
      route ? url_with_params(route, params) : fail(Error, "Route '#{name}' not found.")
    end

    def path
      $window.location.path
    end

    def current_url?(name)
      path == url_for(name, params)
    end

    def url_with_params(route, params)
      path = route[:path]
      params.each do |key, value|
        path = path.gsub(":#{key}", "#{value}")
      end if params
      path
    end
  end
end
