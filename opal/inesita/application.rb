module Inesita
  class Application
    include Inesita::Component

    attr_reader :layout

    def initialize(options)
      raise 'Mount point missing' unless options[:mount]
      raise 'Routes missing' unless options[:routes]

      @router = Router.new(options[:routes])
      @mount = options[:mount]
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

    def run
      mount(@mount)
    end
  end
end
