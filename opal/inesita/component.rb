module Inesita
  module Component
    include VirtualDOM::DOM
    include ComponentWiths

    def mount_to(element)
      @root_component = self
      @virtual_dom = render_virtual_dom
      @root_node = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @root_node
    end

    def render_if_root
      if @virtual_dom && @root_node
        new_virtual_dom = render_virtual_dom
        diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
        VirtualDOM.patch(@root_node, diff)
        @virtual_dom = new_virtual_dom
      end
    end

    def render_virtual_dom
      @__virtual_nodes__ = []
      render
      if @__virtual_nodes__.length == 1
        @__virtual_nodes__.first
      else
        VirtualDOM::VirtualNode.new('div', {}, @__virtual_nodes__).vnode
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

    def a(params, &block)
      params = { onclick: -> { @router.handle_link(params[:href]) } }.merge(params) if params[:href] && @router
      @__virtual_nodes__ ||= []
      if block
        current = @__virtual_nodes__
        @__virtual_nodes__ = []
        result = block.call
        vnode = VirtualDOM::VirtualNode.new('a', process_params(params), @__virtual_nodes__.count == 0 ? result : @__virtual_nodes__).vnode
        @__virtual_nodes__ = current
      else
        vnode = VirtualDOM::VirtualNode.new('a', process_params(params), []).vnode
      end
      @__virtual_nodes__ << vnode
      vnode
    end

    def component(comp, opts = {})
      fail "Component is nil in #{self.class} class" if comp.nil?
      @__virtual_nodes__ ||= []
      @__virtual_nodes__ << cache_component(comp) do
        (comp.is_a?(Class) ? comp.new : comp)
          .with_root_component(@root_component)
          .with_router(@router)
          .with_store(@store)
      end.with_props(opts[:props] || {}).render_virtual_dom
    end
  end
end
