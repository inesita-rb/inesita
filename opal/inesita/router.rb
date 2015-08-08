module Inesita
  class Router
    include Inesita::Component
    class << self; attr_accessor :handle_browser_history; end

    components :routes

    def initialize(routes)
      default_component = routes.values.first.new

      @routes = Hash.new(default_component)
      routes.map do |route, component|
        @routes[route] = component.new
      end

      handle_browser_history
    end

    def render
      dom do
        component routes[url]
      end
    end

    def handle_browser_history
      `window.onpopstate = function(){#{update_dom!}}`
      `window.addEventListener("hashchange", function(){#{update_dom!}})`
      self.class.handle_browser_history = true
    end

    def self.handle_link(path, component)
      `window.history.pushState({}, null, #{path})`
      component.update_dom!
      false
    end

  end
end
