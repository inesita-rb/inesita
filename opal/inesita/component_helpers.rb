module Inesita
  module ComponentHelpers
    def class_names(hash)
      class_names = []
      hash.each do |key, value|
        class_names << key if value
      end
      class_names.join(' ')
    end
  end
end
