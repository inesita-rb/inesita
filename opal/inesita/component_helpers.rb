module Inesita
  module ComponentHelpers
    def inject(name, what)
      Injection.class_eval do
        define_method(name) do
          what
        end
      end
      what
    end

    def class_names(hash)
      class_names = []
      hash.each do |key, value|
        class_names << key if value
      end
      class_names.join(' ')
    end
  end
end
