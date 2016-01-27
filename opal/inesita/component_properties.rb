module Inesita
  module ComponentProperties
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

    attr_reader :store
    def with_store(store)
      @store = store
      self
    end

    attr_reader :props
    def with_props(props)
      @props = props
      self
    end

    attr_reader :dispatcher
    def with_dispatcher(dispatcher)
      @dispatcher = dispatcher
      self
    end
  end
end
