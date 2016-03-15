module Inesita
  module Store
    def store
      self
    end

    def update_dom
      $console.warn "Use 'render!' instead of 'update_dom'"
      render!
    end

    def render!
      root_component.render!
    end

    attr_reader :root_component
    def with_root_component(component)
      @root_component = component
      self
    end

    attr_reader :router
    def with_router(router)
      @router = router
      self
    end
  end
end
