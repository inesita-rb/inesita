module Inesita
  module Component
    include VirtualDOM::DOM
    include ComponentProperties
    include ComponentVirtualDomExtension

    def render
      fail Error, "Implement #render in #{self.class} component"
    end

    def mount_to(element)
      fail Error, "Can't mount #{self.class}, target element not found!" unless element
      @root_component = self
      @virtual_dom = render_virtual_dom
      @root_node = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @root_node
      @root_component.call_after_render
      self
    end

    def render_if_root
      return unless @virtual_dom && @root_node
      new_virtual_dom = render_virtual_dom
      diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
      VirtualDOM.patch(@root_node, diff)
      @virtual_dom = new_virtual_dom
    end

    def render_virtual_dom
      @after_render_callbacks = []
      @root_component.add_after_render(method(:after_render)) if respond_to?(:after_render)
      @cache_component_counter = 0
      @__virtual_nodes__ = []
      render
      if @__virtual_nodes__.length == 1
        @__virtual_nodes__.first
      else
        VirtualDOM::VirtualNode.new('div', {}, @__virtual_nodes__).to_n
      end
    end

    def add_after_render(block)
      @after_render_callbacks << block
    end

    def call_after_render
      @after_render_callbacks.reverse_each(&:call)
    end

    def update_dom
      $console.warn "Use 'render!' instead of 'update_dom'"
      render!
    end

    def render!
      animation_frame do
        if @root_component
          @root_component.render_if_root
          @root_component.call_after_render
        end
      end
    end

    def cache_component(component, &block)
      @cache_component ||= {}
      @cache_component_counter ||= 0
      @cache_component_counter += 1
      @cache_component["#{component}-#{@cache_component_counter}"] || @cache_component["#{component}-#{@cache_component_counter}"] = block.call
    end
  end
end
