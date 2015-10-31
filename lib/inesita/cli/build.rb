class InesitaCLI < Thor
  include Thor::Actions

  check_unknown_options!

  namespace :build

  desc "build [OPTIONS]", "Build Inesita app"

  method_option :force,
                aliases: ['-f'],
                default: false,
                desc: 'force overwrite'

  method_option :destination,
                aliases: ['-d', '-dir'],
                default: 'public',
                desc: 'build destination directory'

  def build
    Inesita.env = :production
    build_dir = options[:destination]

    assets = Inesita::Server.new.assets_app

    index = assets['index.html']
    javascript = assets['application.js']
    stylesheet = assets['stylesheet.css']

    minify_html = -> (source) do
      if defined? HtmlCompressor && HtmlCompressor::Compressor
        HtmlCompressor::Compressor.new.compress(source)
      else
        source
      end
    end

    minify_js = -> (source) do
      if defined? Uglifier
        Uglifier.compile(source)
      else
        source
      end
    end

    minify_css = -> (source) do
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

    empty_directory build_dir, force: options[:force]
    create_file File.join(build_dir, 'index.html'),     minify_html[index.source],     force: options[:force]
    create_file File.join(build_dir, 'application.js'), minify_js[javascript.source],  force: options[:force]
    create_file File.join(build_dir, 'stylesheet.css'), minify_css[stylesheet.source], force: options[:force]
  end
end
