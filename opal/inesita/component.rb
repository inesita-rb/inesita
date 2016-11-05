module Inesita
  module Component
    include VirtualDOM::DOM
    include VirtualDom
    include Render
    include Cache
    include Injection

    def self.included(base)
      base.extend Inesita::Component::ClassMethods
    end

    def mount_to(element)
      raise Error, "Can't mount #{self.class}, target element not found!" unless element
      @root_component = self
      init_injections
      inject
      @virtual_dom = render_virtual_dom
      @root_node = VirtualDOM.create(@virtual_dom)
      Browser.append_child(element, @root_node)
      self
    end

    attr_reader :props
    def with_props(props)
      @props = props
      self
    end
  end
end
