module Inesita
  class Application
    include Inesita::Component

    def initialize(options = {})
      setup_router(options.delete(:router))
      setup_layout(options.delete(:layout))
      setup_root
      setup_injections(options)
    end

    def render
      component @root
    end

    private

    def setup_router(router)
      if router
        raise Error, "Invalid #{router} class, should mixin Inesita::Router" unless router.include?(Inesita::Router)
        @router = inject(:router, router.new)
      else
        @router = Class.new { define_method(:method_missing) { raise 'Router missing' } }.new
      end
    end

    def setup_layout(layout)
      if layout
        raise Error, "Invalid #{layout} class, should mixin Inesita::Layout" unless layout.include?(Inesita::Layout)
        @layout = inject(:layout, layout.new)
      end
    end

    def setup_root
      if @layout
        @root = @layout
      elsif @router
        @root = @router
      else
        raise Error, 'Router or Layout not found!'
      end
    end

    def setup_injections(injections)
      return unless injections
      return unless injections.is_a?(Hash)
      injections.each do |key, value|
        inject(key, value.new)
      end
    end
  end
end
