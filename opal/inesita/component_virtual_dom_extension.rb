module Inesita
  module ComponentVirtualDomExtension
    def component(comp, opts = {})
      raise Error, "Component is nil in #{self.class} class" if comp.nil?
      @__virtual_nodes__ ||= []
      @__virtual_nodes__ << cache_component(comp) do
        (comp.is_a?(Class) ? comp.new : comp)
          .with_root_component(@root_component)
          .inject
      end.with_props(opts[:props] || {}).render_virtual_dom
      self
    end
  end
end
