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

    empty_directory build_dir, force: options[:force]
    create_file File.join(build_dir, 'index.html'),     Inesita::Minify.html(index.source),     force: options[:force]
    create_file File.join(build_dir, 'application.js'), Inesita::Minify.js(javascript.source),  force: options[:force]
    create_file File.join(build_dir, 'stylesheet.css'), Inesita::Minify.css(stylesheet.source), force: options[:force]
  end
end
