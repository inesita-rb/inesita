module Inesita
  module ComponentVirtualDomExtension
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
      fail Error, "Component is nil in #{self.class} class" if comp.nil?
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

