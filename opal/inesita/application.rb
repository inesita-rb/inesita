module Inesita
  class Application
    include Inesita::Component

    def initialize(options = {})
      router = options[:router]
      layout = options[:layout]
      store  = options[:store]

      fail Error, 'Router missing' unless router
      fail Error, "Invalid #{router} class, should mixin Inesita::Router" unless router.include?(Inesita::Router)
      fail Error, "Invalid #{layout} class, should mixin Inesita::Layout" if layout && !layout.include?(Inesita::Layout)
      fail Error, "Invalid #{store} class, should mixin Inesita::Store" if store && !store.include?(Inesita::Store)

      @router = router.new
      @layout = layout.new if layout

      @root   = @layout ? @layout : @router
      @store  = store.new.with_root_component(@root).store if store
    end

    def render
      component @root
    end
  end
end
