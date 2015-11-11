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
    end

    def render_if_root
      return unless @virtual_dom && @root_node
      new_virtual_dom = render_virtual_dom
      diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
      VirtualDOM.patch(@root_node, diff)
      @virtual_dom = new_virtual_dom
    end

    def render_virtual_dom
      @cache_component_counter = 0
      @__virtual_nodes__ = []
      render
      if @__virtual_nodes__.length == 1
        @__virtual_nodes__.first
      else
        VirtualDOM::VirtualNode.new('div', {}, @__virtual_nodes__).to_n
      end
    end

    def update_dom
      puts @root_component.inspect
      @root_component.render_if_root
    end

    def cache_component(component, &block)
      @cache_component ||= {}
      @cache_component_counter ||= 0
      @cache_component_counter += 1
      @cache_component["#{component}-#{@cache_component_counter}"] || @cache_component["#{component}-#{@cache_component_counter}"] = block.call
    end
  end
end
