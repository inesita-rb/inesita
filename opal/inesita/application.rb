module Inesita
  class Application
    include Inesita::Component

    components :layout

    def initialize(options)
      raise 'Router missing' unless options[:router]

      @router = options[:router].new
      @layout = options[:layout]
    end

    def render
      dom do
        if layout
          component layout
        else
          component router
        end
      end
    end
  end
end
