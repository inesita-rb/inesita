module Inesita
  module Store
    def store
      self
    end

    def update_dom
      root_component.update!
    end

    attr_reader :root_component
    def with_root_component(component)
      @root_component = component
      self
    end
  end
end
