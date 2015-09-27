module Inesita
  module Router
    include Inesita::JSHelpers
    include Inesita::Component

    def initialize
      on_popstate method(:update!)
      on_hashchange method(:update!)
      @routes = Routes.new
      routes
      puts @routes.routes
      puts @routes.route_names
    end

    def routes; end

    def route(*params, &block)
      @routes.route(*params, &block)
    end

    def find_component
      @routes.routes[path]
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
  end
end
