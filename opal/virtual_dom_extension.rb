module VirtualDOM
  class NodeFactory
    def component(comp)
      @nodes << NodeFactory.new(comp.method(:render), comp).nodes.first
    end
  end
end
