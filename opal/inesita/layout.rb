module Inesita
  module Layout
    def self.included(base)
      base.include(Component)
    end

    def outlet
      @router
    end
  end
end
