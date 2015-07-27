module Inesita
  class Router
    include Inesita::Component
    attr_reader :routes

    def initialize(routes)
      default_component = routes.values.first.new
      default_component.parent(self)

      @routes = Hash.new(routes['/'].new)
      routes.map do |route, component|
        @routes[route] = component.new
        @routes[route].parent(self)
      end
    end

    def render
      component routes[url]
    end

    def mount
      `window.onpopstate = function(){#{self.handle_link}}`
      `window.addEventListener("hashchange", function(){#{self.handle_link}})`
      super
    end


    def self.handle_link(path, component)
      `window.history.pushState({}, null, #{path})`
      component.update
      false
    end

  end
end
