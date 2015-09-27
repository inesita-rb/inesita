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
      component_params = params.last[:params]

      add_subroutes(path, &block) if block_given?
      add_route(name, path, component, component_params) if component
    end

    def add_route(name, path, component, component_params)
      @routes << {
        path: path,
        component: component,
        component_params: component_params,
        name: name || component.class.to_s.downcase
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
      if parts.empty?
        regex << '\/'
      else
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
      end
      regex << '$'
      {
        regex: Regexp.new(regex.join),
        params: params
      }
    end
  end
end
