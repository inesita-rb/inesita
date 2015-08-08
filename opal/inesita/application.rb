module Inesita
  class Application
    include Inesita::Component

    components :parent

    def initialize(options)
      raise 'Routes missing' unless options[:routes]

      @router = Router.new(options[:routes])
      @layout = options[:layout]

      @parent = @layout ? @layout.create(@router) : @router
      puts @layout.create(@router).inspect

    end

    def render
      dom do
        component parent
      end
    end
  end
end
