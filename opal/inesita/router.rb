module Inesita
  module Router
    include Inesita::Component

    attr_reader :params

    def initialize
      @routes = Routes.new
      raise Error, 'Add #routes method to router!' unless respond_to?(:routes)
      routes
      raise Error, 'Add #route to your #routes method!' if @routes.routes.empty?
      find_route
      parse_url_params
      add_listeners
    end

    def add_listeners
      Browser.onpopstate { find_route; parse_url_params; render! }
      Browser.hashchange { find_route; parse_url_params; render! }
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
      raise Error, "Can't find route for url"
    end

    def find_component(route)
      call_on_enter_callback(route)
      @component_props = route[:component_props]
      route[:component]
    end

    def render
      component find_component(@route), props: @component_props if @route
    end

    def call_on_enter_callback(route)
      return unless route[:on_enter]
      if route[:on_enter].respond_to?(:call)
        route[:on_enter].call
      end
    end

    def go_to(path)
      Browser.push_state(path)
      find_route
      parse_url_params
      render!
      false
    end

    def parse_url_params
      @params = compotent_url_params
      query[1..-1].split('&').each do |param|
        key, value = param.split('=')
        @params[Browser.decode_uri_component(key)] = Browser.decode_uri_component(value)
      end unless query.empty?
    end

    def compotent_url_params
      Hash[@route[:params].zip(path.match(@route[:regex])[1..-1])]
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
      route ? url_with_params(route, params) : raise(Error, "Route '#{name}' not found.")
    end

    def query
      Browser.query
    end

    def path
      Browser.path
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
