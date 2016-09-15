module Inesita
  class Routes
    attr_reader :routes

    def initialize(parent = nil)
      @parent = parent
      @routes = []
    end

    def route(*params, &block)
      path = params.first.gsub(/^\//, '')
      path = @parent ? "#{@parent}/#{path}" : "/#{path}"

      add_subroutes(path, &block) if block_given?

      if params.last[:redirect_to]
        add_redirect(path, params.last[:redirect_to])
      else
        add_route(params.last[:as], path, params.last[:to], params.last[:props], params.last[:on_enter])
      end
    end

    def validate_component(component)
      raise Error, 'Component not exists' unless component
      raise Error, "Invalid #{component} class, should mixin Inesita::Component" unless component.include?(Inesita::Component)
    end

    def add_redirect(path, redirect_to)
      @routes << {
        path: path,
        redirect_to: redirect_to
      }.merge(build_params_and_regex(path))
    end

    def add_route(name, path, component, component_props, on_enter)
      validate_component(component)
      @routes << {
        path: path,
        component: component,
        component_props: component_props,
        on_enter: on_enter,
        name: name || component.to_s.gsub(/(.)([A-Z])/, '\1_\2').downcase
      }.merge(build_params_and_regex(path))
    end

    def add_subroutes(path, &block)
      subroutes = Routes.new(path)
      subroutes.instance_exec(&block)
      @routes += subroutes.routes
    end

    def build_params_and_regex(path)
      regex = ['^']
      params = []
      parts = path.split('/')
      regex << '\/' if parts.empty?
      parts.each do |part|
        next if part.empty?
        regex << '\/'
        case part[0]
        when ':'
          params << part[1..-1]
          regex << '([^\/]+)'
        when '*'
          params << part[1..-1]
          regex << '(.*)'
          break
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
