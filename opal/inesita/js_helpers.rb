module Inesita
  module JSHelpers
    def on_popstate(fn)
      `window.onpopstate = function(){#{fn}}`
    end

    def on_hashchange(fn)
      `window.addEventListener("hashchange", function(){#{fn}})`
    end

    def push_state(path)
      `window.history.pushState({}, null, #{path})`
    end

    def path
      `document.location.pathname`
    end
  end
end
