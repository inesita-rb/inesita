module Inesita
  module Component
    include VirtualDOM::DOM
    include ComponentVirtualDomExtension

    def render
      raise Error, "Implement #render in #{self.class} component"
    end

    def self.included(base)
      base.extend Inesita::ComponentClassMethods
    end

    def mount_to(element)
      raise Error, "Can't mount #{self.class}, target element not found!" unless element
      init_injections
      @root_component = self
      inject
      @virtual_dom = render_virtual_dom
      @root_node = VirtualDOM.create(@virtual_dom)
      Browser.append_child(element, @root_node)
      self
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

    def cache_component(component, &block)
      @cache_component ||= {}
      @cache_component_counter ||= 0
      @cache_component_counter += 1
      @cache_component["#{component}-#{@cache_component_counter}"] || @cache_component["#{component}-#{@cache_component_counter}"] = block.call
    end

    def hook(mthd)
      VirtualDOM::Hook.method(method(mthd))
    end

    def unhook(mthd)
      VirtualDOM::UnHook.method(method(mthd))
    end

    attr_reader :props
    def with_props(props)
      @props = props
      self
    end

    def with_root_component(component)
      @root_component = component
      self
    end

    def render!
      Browser.animation_frame do
        @root_component.render_if_root
      end
    end

    def inject
      @root_component.injections.each do |name, instance|
        define_singleton_method(name) do
          instance
        end
      end
      self
    end

    attr_reader :injections
    def init_injections
      self.class.injections.each do |name, instance|
        @injections ||= {}
        @injections[name] = instance.new
      end
    end
  end
end
