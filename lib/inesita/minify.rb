module Minify
  module_function

  def html(source)
    if defined? HtmlCompressor && HtmlCompressor::Compressor
      HtmlCompressor::Compressor.new.compress(source)
    else
      source
    end
  end

  def js(source)
    if defined? Uglifier
      Uglifier.compile(source)
    else
      source
    end
  end

  def css(source)
    if defined? Sass && Sass::Engine
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
