module Inesita
  module Store
    # TODO: Remove it.
    def self.included(base)
      $console.warn('"include Inesita::Store" is deprecated. Use "include Inesita::Injection" insted.')
      include Injection
    end
  end
end
