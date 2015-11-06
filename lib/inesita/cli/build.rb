class InesitaCLI < Thor
  include Thor::Actions

  check_unknown_options!

  namespace :build

  desc 'build [OPTIONS]', 'Build Inesita app'

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
    assets = Inesita::Server.new.assets_app

    build_dir = options[:destination]
    html = assets['index.html'].source
    javascript = assets['application.js'].source
    stylesheet = assets['stylesheet.css'].source
    force = options[:force]

    empty_directory build_dir, force: force
    create_file File.join(build_dir, 'index.html'),     Inesita::Minify.html(html),      force: force
    create_file File.join(build_dir, 'application.js'), Inesita::Minify.js(javascript),  force: force
    create_file File.join(build_dir, 'stylesheet.css'), Inesita::Minify.css(stylesheet), force: force
  end
end
