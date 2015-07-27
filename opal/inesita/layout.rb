module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def create(outlet)
        new.tap do |l|
          l.component :outlet, outlet
        end
      end
    end
  end
end
