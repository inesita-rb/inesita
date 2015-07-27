module Inesita
  class Application
    include Inesita::Component

    attr_reader :layout

    def initialize(options)
      raise 'Routes missing' unless options[:routes]

      @router = Router.new(options[:routes])
      @layout = options[:layout]

      component :parent, @layout ? @layout.create(@router) : @router
    end

    def render
      component parent
    end
  end
end
