module Inesita
  module Minify
    module_function

    def html(source)
      if defined?(HtmlCompressor) && defined?(HtmlCompressor::Compressor)
        HtmlCompressor::Compressor.new.compress(source)
      else
        source
      end
    end

    def js(source)
      if defined?(Uglifier)
        Uglifier.compile(source, harmony: true)
      else
        source
      end
    end

    def css(source)
      if defined?(Sass) && defined?(Sass::Engine)
        Sass::Engine.new(source,
                         syntax:     :scss,
                         cache:      false,
                         read_cache: false,
                         style:      :compressed
                        ).render
      else
        source
      end
    end
  end
end
