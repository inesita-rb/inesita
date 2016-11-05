module Inesita
  module Component
    module Cache
      def cache_component(component, &block)
        @cache_component ||= {}
        @cache_component_counter ||= 0
        @cache_component_counter += 1
        @cache_component["#{component}-#{@cache_component_counter}"] || @cache_component["#{component}-#{@cache_component_counter}"] = block.call
      end
    end
  end
end
