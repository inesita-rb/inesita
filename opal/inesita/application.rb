module Inesita
  class Application
    include Inesita::Component

    def initialize(options = {})
      setup_router(options[:router])
      setup_layout(options[:layout])
      setup_store(options[:store])
    end

    def render
      component @root
    end

    private

    def setup_router(router)
      fail Error, 'Router missing' unless router
      fail Error, "Invalid #{router} class, should mixin Inesita::Router" unless router.include?(Inesita::Router)
      @router = router.new
    end

    def setup_layout(layout)
      if layout
        fail Error, "Invalid #{layout} class, should mixin Inesita::Layout" unless layout.include?(Inesita::Layout)
        @root = layout.new
      else
        @root = @router
      end
    end

    def setup_store(store)
      return unless store
      fail Error, "Invalid #{store} class, should mixin Inesita::Store" unless store.include?(Inesita::Store)
      @store = store.new.with_root_component(@root).store
    end
  end
end
