module Inesita
  module Injection
    def with_root_component(component)
      @root_component = component
      self
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
        if instance.include(Inesita::Injection)
          @injections[name] = instance
            .new
            .with_root_component(@root_component)
            .inject
        else
          $console.warn "Bla"
        end
      end
    end

    def render!
      Browser.animation_frame do
        @root_component.render_if_root
      end
    end
  end
end
