module Inesita
  class Routes
    attr_reader :routes, :route_names

    def initialize(parent = nil)
      @parent = parent
      @routes = []
    end

    def route(*params, &block)
      path = params.first.delete('/')
      path = @parent ? "#{@parent}/#{path}" : "/#{path}"
      component = params.last[:to]
      name = params.last[:as]
      component_props = params.last[:props]

      add_subroutes(path, &block) if block_given?
      validate_component(component)
      add_route(name, path, component, component_props)
    end

    def validate_component(component)
      fail Error, 'Component not exists' unless component
      fail Error, "Invalid #{component} class, should mixin Inesita::Component" unless component.include?(Inesita::Component)
    end

    def add_route(name, path, component, component_props)
      @routes << {
        path: path,
        component: component,
        component_props: component_props,
        name: name || component.to_s.gsub(/(.)([A-Z])/, '\1_\2').downcase
      }.merge(params_and_regex(path))
    end

    def add_subroutes(path, &block)
      subroutes = Routes.new(path)
      subroutes.instance_exec(&block)
      @routes += subroutes.routes
    end

    def params_and_regex(path)
      regex = ['^']
      params = []
      parts = path.split('/')
      regex << '\/' if parts.empty?
      parts.each do |part|
        next if part.empty?
        regex << '\/'
        if part[0] == ':'
          params << part[1..-1]
          regex << '([^\/]+)'
        else
          regex << part
        end
      end
      regex << '$'
      {
        regex: Regexp.new(regex.join),
        params: params
      }
    end
  end
end
