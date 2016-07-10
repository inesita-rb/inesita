module Inesita
  module Store

    def init; end
    def store; self end

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
