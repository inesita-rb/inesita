module VirtualDOM
  class NodeFactory
    def component(comp)
      @nodes << NodeFactory.new(comp.method(:render), comp).nodes.first
    end

    def a(params, &block)
      params = { onclick: -> { Inesita::Router.handle_link(params[:href], @parent) } }.merge(params) if params[:href] && Inesita::Router.initialized
      @nodes << VirtualNode.new(
        'a',
        process_params(params),
        block ? NodeFactory.new(block, @parent).nodes : []
      ).vnode
    end
  end
end
