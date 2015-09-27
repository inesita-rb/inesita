module Inesita
  class Routes
    attr_reader :routes, :route_names

    def initialize(parent = nil)
      @parent = parent
    end

    def route(*params, &block)
      @routes ||= {}
      @route_names ||= {}

      path = params.first.delete('/')
      path = @parent ? "#{@parent}/#{path}" : "/#{path}"
      component = params.last[:to]
      name = params.last[:as]

      add_subroutes(path, &block) if block_given?
      add_route(path, component, name) if component
    end

    def add_route(path, component, name)
      @routes[path] = component
      @route_names[name || component.class.to_s.downcase] = path
    end

    def add_subroutes(path, &block)
      subroutes = Routes.new(path)
      subroutes.instance_exec(&block)
      @routes = @routes.merge(subroutes.routes)
      @route_names = @route_names.merge(subroutes.route_names)
    end
  end
end
