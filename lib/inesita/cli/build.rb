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
                default: Inesita::Config::BUILD_DIR,
                desc: 'build destination directory'

  def build
    Inesita.dist!
    assets = Inesita::Server.new.assets_app

    build_dir = options[:destination]
    force = options[:force]

    empty_directory build_dir, force: force

    copy_static(build_dir, force)
    create_index(build_dir, assets['index.html'].source, force)
    create_js(build_dir, assets['application.js'].source, force)
    create_css(build_dir, assets['stylesheet.css'].source, force)
  end

  no_commands do
    def copy_static(build_dir, force)
      Dir.glob('./static/**/*').each do |file|
        if File.directory?(file)
          empty_directory File.join(build_dir, file), force: force
        else
          copy_file File.absolute_path(file), File.join(build_dir, file), force: force
        end
      end
    end

    def create_index(build_dir, html, force)
      create_file File.join(build_dir, 'index.html'), Inesita::Minify.html(html), force: force
    end

    def create_js(build_dir, javascript, force)
      create_file File.join(build_dir, 'application.js'), Inesita::Minify.js(javascript),  force: force
    end

    def create_css(build_dir, stylesheet, force)
      create_file File.join(build_dir, 'stylesheet.css'), Inesita::Minify.css(stylesheet), force: force
    end
  end
end
