module Inesita
  class Router
    include Inesita::Component
    attr_reader :routes

    def initialize(routes)
      default_component = routes.values.first.new
      default_component.parent(self)

      @routes = Hash.new(default_component)
      routes.map do |route, component|
        @routes[route] = component.new
        @routes[route].parent(self)
      end

      `window.onpopstate = function(){#{update}}`
      `window.addEventListener("hashchange", function(){#{update}})`
    end

    def render
      component routes[url]
    end

    def self.handle_link(path, component)
      `window.history.pushState({}, null, #{path})`
      component.update
      false
    end

  end
end
