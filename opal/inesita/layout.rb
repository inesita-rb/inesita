module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
    end

    attr_reader :outlet

    def initialize(outlet)
      self.class.component :outlet, outlet
    end
  end
end
