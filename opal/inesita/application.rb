module Inesita
  class Application
    include Inesita::Component

    attr_reader :root

    def initialize(options)
      router = options[:router]
      layout = options[:layout]
      store  = options[:store]

      raise 'Router missing' unless router
      raise "Invalid #{router} class, should mixin Inesita::Router" unless router.include?(Inesita::Router)
      raise "Invalid #{layout} class, should mixin Inesita::Layout" unless layout.include?(Inesita::Layout)
      raise "Invalid #{store} class, should mixin Inesita::Store" unless store.include?(Inesita::Store)

      @router = router.new
      @layout = layout.new if layout

      @root   = @layout ? @layout : @router
      @store  = store.new.with_root_component(@root).store if store
    end

    def render
      component root
    end
  end
end
