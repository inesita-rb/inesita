module Inesita
  module Component
    include VirtualDOM

    def with_parent(component)
      @parent = component
      self
    end

    def dom(&block)
      NodeFactory.new(block, self).nodes.first
    end

    def mount(element)
      @virtual_dom = render
      @mount_point = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @mount_point
    end

    def update
      if @virtual_dom && @mount_point
        new_virtual_dom = render
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

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def components(*attrs)
        #fail "Forbidden component name '#{name}' in #{self.class} component" if VirtualDOM::NodeFactory::HTML_TAGS.include?(name)
        attr_reader *attrs.flatten
      end
    end
  end
end
