module Inesita
  module Component
    include VirtualDOM
    include ComponentWiths

    def dom(&block)
      nodes = NodeFactory.new(block, self).nodes
      @cache_component_counter = nil
      if nodes.length == 1
        nodes.first
      else
        VirtualNode.new('div', {}, nodes).vnode
      end
    end

    def mount_to(element)
      @root_component = self
      @virtual_dom = render
      @root_node = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @root_node
    end

    def render_if_root
      if @virtual_dom && @root_node
        new_virtual_dom = render
        diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
        VirtualDOM.patch(@root_node, diff)
        @virtual_dom = new_virtual_dom
      end
    end

    def update_dom
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
