module Inesita
  class Application
    include Inesita::Component

    components :parent

    def initialize(options)
      raise 'Router missing' unless options[:router]

      @router = options[:router].new
      @layout = options[:layout].new

      @parent = @layout ? @layout.with_outlet(@router) : @router
    end

    def render
      dom do
        component parent
      end
    end
  end
end
