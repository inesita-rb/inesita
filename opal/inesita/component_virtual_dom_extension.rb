module Inesita
  module ComponentVirtualDomExtension
    def self.included(base)
      base.alias_method :__a, :a
      base.define_method(:a) do |params, &block|
        params = { onclick: -> { @router.handle_link(params[:href]) } }.merge(params) if params[:href] && @router
        __a(params, &block)
      end
    end

    def component(comp, opts = {})
      fail Error, "Component is nil in #{self.class} class" if comp.nil?
      @__virtual_nodes__ ||= []
      @__virtual_nodes__ << cache_component(comp) do
        (comp.is_a?(Class) ? comp.new : comp)
          .with_root_component(@root_component)
          .with_router(@router)
          .with_store(@store)
          .with_dispatcher(@dispatcher)
      end.with_props(opts[:props] || {}).render_virtual_dom
    end
  end
end
