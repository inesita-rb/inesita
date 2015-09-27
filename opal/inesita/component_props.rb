module Inesita
  module ComponentProps
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

    attr_reader :params
    def with_params(params)
      @params = params
      self
    end
  end
end
