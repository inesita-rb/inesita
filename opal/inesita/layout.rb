module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
      base.extend(ClassMethods)
      base.components :outlet
    end

    def with_outlet(outlet)
      @outlet = outlet
      self
    end

    module ClassMethods
      def create(outlet)
        new.with_outlet(outlet)
      end
    end
  end
end
