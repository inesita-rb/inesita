module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
    end

    attr_reader :outlet

    def initialize(outlet)
      @outlet = outlet
    end
  end
end
