module Inesita
  # TODO: Remove it.
  module Store
    def self.included(base)
      $console.warn('"include Inesita::Store" is deprecated. Use "include Inesita::Injection" insted.')
      self.include Injection
    end

    def render!
      Browser.animation_frame do
        root_component.render_if_root
      end
    end
  end
end
