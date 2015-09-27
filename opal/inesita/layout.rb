module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
      base.components :outlet
    end

    def with_outlet(outlet)
      @outlet = outlet
      self
    end
  end
end
