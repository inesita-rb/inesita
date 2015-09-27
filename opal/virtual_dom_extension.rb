module VirtualDOM
  class NodeFactory
    def component(comp, params = nil)
      fail "Component is nil in #{@parent.class} class" if comp.nil?
      component = comp.is_a?(Class) ? comp.new : comp
      @nodes << component
        .with_root_component(@parent.root_component)
        .with_router(@parent.router)
        .with_store(@parent.store)
        .with_params(params)
        .render
    end

    def a(params, &block)
      params = { onclick: -> { @parent.router.handle_link(params[:href]) } }.merge(params) if params[:href] && @parent.router
      @nodes << VirtualNode.new(
        'a',
        process_params(params),
        block ? NodeFactory.new(block, @parent).nodes : []
      ).vnode
    end
  end
end
