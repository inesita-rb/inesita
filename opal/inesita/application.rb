module Inesita
  class Application
    include Inesita::Component

    attr_reader :layout

    def initialize(options)
      raise 'Routes missing' unless options[:routes]

      @router = Router.new(options[:routes])
      @layout = options[:layout]

      if @layout
        self.class.component :layout_component, @layout.new(@router)
      else
        self.class.component :router_component, @router
      end
    end

    def render
      component layout ? layout_component : router_component
    end
  end
end
