module Inesita
  module Browser
    module_function

    Window = JS.global
    Document = Window.JS[:document]
    RequestAnimationFrame = Window.JS[:requestAnimationFrame]
    Location = Document.JS[:location]
    History = Window.JS[:history]
    AddEventListener = Window.JS[:addEventListener]

    def animation_frame(&block)
      RequestAnimationFrame.call(block)
    end

    def path
      Location.JS[:pathname]
    end

    def query
      Location.JS[:search]
    end

    def decode_uri_component(value)
      JS.decodeURIComponent(value)
    end

    def push_state(path)
      History.JS.pushState({}, nil, path)
    end

    def onpopstate(&block)
      Window.JS[:onpopstate] = block
    end

    def hashchange(&block)
      AddEventListener.call(:hashchange, block)
    end

    def ready?(&block)
      AddEventListener.call('load', block)
    end

    def body
      Document.JS[:body]
    end

    def append_child(node, new_node)
      node.JS.appendChild(new_node)
    end
  end
end
