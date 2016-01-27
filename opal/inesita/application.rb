module Inesita
  class Application
    include Inesita::Component

    def initialize(options = {})
      setup_dispatcher(options[:dispatcher])
      setup_router(options[:router])
      setup_layout(options[:layout])
      setup_root
      setup_store(options[:store])
    end

    def render
      component @root
    end

    private

    def setup_router(router)
      if router
        fail Error, "Invalid #{router} class, should mixin Inesita::Router" unless router.include?(Inesita::Router)
        @router = router.new
      else
        @router = Class.new { define_method(:method_missing) { fail 'Router missing' } }.new
      end
    end

    def setup_layout(layout)
      if layout
        fail Error, "Invalid #{layout} class, should mixin Inesita::Layout" unless layout.include?(Inesita::Layout)
        @layout = layout.new
      end
    end

    def setup_root
      if @layout
        @root = @layout
      elsif @router
        @root = @router
      else
        fail Error, 'Router or Layout not found!'
      end
    end

    def setup_store(store)
      return unless store
      fail Error, "Invalid #{store} class, should mixin Inesita::Store" unless store.include?(Inesita::Store)
      @store = store.new.with_root_component(@root).with_dispatcher(@dispatcher).store
    end

    def setup_dispatcher(dispatcher)
      return unless dispatcher
      fail Error, "Invalid #{dispatcher} class, should mixin Inesita::ActionDispatcher" unless dispatcher.include?(Inesita::Dispatcher)
      @dispatcher = dispatcher.new
      fail Error, "You must define `actions` method on #{dispatcher} class" unless @dispatcher.respond_to?(:actions)
    end
  end
end
