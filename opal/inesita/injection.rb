module Inesita
  module Injection
    def render!
      Browser.animation_frame do
        root_component.render_if_root
      end
    end
  end
end
