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
      @root_component.call_on_mounted
      self
    end

    def add_on_mounted_callback(block)
      @on_mounted_callbacks << block
    end

    def call_on_mounted
      @on_mounted_callbacks.reverse_each(&:call)
    end

    attr_reader :props
    def with_props(props)
      @props = props
      self
    end
  end
end
