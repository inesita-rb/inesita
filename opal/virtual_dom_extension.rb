module VirtualDOM
  class NodeFactory
    def component(comp)
      fail "Component is nil in #{@parent.class} class" if comp.nil?
      @nodes << comp.with_parent(@parent).setup_and_render
    end

    def a(params, &block)
      params = { onclick: -> { Inesita::Router.handle_link(params[:href], @parent) } }.merge(params) if params[:href] && Inesita::Router.handle_browser_history
      @nodes << VirtualNode.new(
        'a',
        process_params(params),
        block ? NodeFactory.new(block, @parent).nodes : []
      ).vnode
    end
  end
end
