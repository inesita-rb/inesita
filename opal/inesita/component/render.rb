module Inesita
  module Component
    module Render
      def render
        raise Error, "Implement #render in #{self.class} component"
      end

      def render_if_root
        return unless @virtual_dom && @root_node
        new_virtual_dom = render_virtual_dom
        diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
        VirtualDOM.patch(@root_node, diff)
        @virtual_dom = new_virtual_dom
      end

      def before_render; end;

      def render_virtual_dom
        before_render
        @cache_component_counter = 0
        @__virtual_nodes__ = []
        render.to_vnode
      end
    end
  end
end
