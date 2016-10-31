module Inesita
  module Browser
    module_function

    Window = JS.global
    Document = Window.JS[:document]
    AddEventListener = Window.JS[:addEventListener]

    if Native(Window.JS[:requestAnimationFrame])
      def animation_frame(&block)
        Window.JS.requestAnimationFrame(block)
      end
    else
      def animation_frame(&block)
        block.call
      end
    end

    def ready?(&block)
      AddEventListener.call('load', block)
    end

    def body
      Document.JS[:body]
    end

    def append_child(node, new_node)
      node = node.to_n unless native?(node)
      new_node = new_node.to_n unless native?(new_node)
      node.JS.appendChild(new_node)
    end

    def query_element(css)
      Document.JS.querySelector(css)
    end
  end
end
