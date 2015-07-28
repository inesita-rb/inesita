module Inesita
  module Component
    include VirtualDOM

    def parent(component)
      @parent = component
      self
    end

    def mount(element)
      @virtual_dom = NodeFactory.new(method(:render), self).nodes.first
      @mount_point = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @mount_point
    end

    def update
      if @virtual_dom && @mount_point
        new_virtual_dom =  NodeFactory.new(method(:render), self).nodes.first
        diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
        VirtualDOM.patch(@mount_point, diff)
        @virtual_dom = new_virtual_dom
      else
        @parent.update
      end
    end

    def url
      `document.location.pathname`
    end

    def component(name, instance)
      var name, instance.parent(self)
    end

    def var(name, instance)
      raise "Forbidden var name '#{name}' in #{self.class} component" if VirtualDOM::NodeFactory::HTML_TAGS.include?(name)
      self.class.define_method name do
        unless instance_variable_get(:"@#{name}")
          instance_variable_set(:"@#{name}", instance)
        end
        instance_variable_get(:"@#{name}")
      end
    end
  end
end
