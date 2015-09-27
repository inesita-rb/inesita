module Inesita
  module Component
    include VirtualDOM
    include ComponentProps

    def dom(&block)
      nodes = NodeFactory.new(block, self).nodes
      if nodes.length == 1
        nodes.first
      else
        VirtualNode.new('div', {}, nodes).vnode
      end
    end

    def mount!(element)
      @root_component = self
      @virtual_dom = render
      @root_node = VirtualDOM.create(@virtual_dom)
      element.inner_dom = @root_node
    end

    def update_root_component!
      if @virtual_dom && @root_node
        new_virtual_dom = render
        diff = VirtualDOM.diff(@virtual_dom, new_virtual_dom)
        VirtualDOM.patch(@root_node, diff)
        @virtual_dom = new_virtual_dom
      end
    end

    def update!
      @root_component.update_root_component!
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def components(*attrs)
        attrs.flatten.each do |component|
          if VirtualDOM::NodeFactory::HTML_TAGS.include?(component)
            fail "Forbidden component name '#{component}' in #{self} component"
          else
            attr_reader component
          end
        end
        attr_reader *attrs.flatten
      end
    end
  end
end
