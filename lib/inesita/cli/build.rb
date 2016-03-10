class InesitaCLI < Thor
  include Thor::Actions

  check_unknown_options!

  namespace :build

  desc 'build [OPTIONS]', 'Build Inesita app'

  method_option :force,
                aliases: ['-f'],
                default: false,
                desc: 'force overwrite'

  method_option :destination_dir,
                aliases: ['-d'],
                default: Inesita::Config::BUILD_DIR,
                desc: 'destination directory'

  method_option :source_dir,
                aliases: ['-s'],
                default: Inesita::Config::APP_DIR,
                desc: 'source (app) dir'

  method_option :static_dir,
                aliases: ['-st'],
                default: Inesita::Config::STATIC_DIR,
                desc: 'static dir'

  method_option :dist_source_dir,
                aliases: ['-ds'],
                default: Inesita::Config::APP_DIST_DIR,
                desc: 'source (app) dir'

  def build
    assets = Inesita::Server.new({
      dist: true,
      static_dir: options[:static_dir],
      app_dir: options[:app_dir],
      app_dist_dir: options[:app_dist_dir]
    }).assets_app

    build_dir = options[:destination_dir]
    force = options[:force]

    empty_directory build_dir, force: force

    copy_static(static_dir, build_dir, force)
    create_index(build_dir, assets['index.html'].source, force)
    create_js(build_dir, assets['application.js'].source, force)
    create_css(build_dir, assets['stylesheet.css'].source, force)
  end

  no_commands do
    def copy_static(static_dir, build_dir, force)
      Dir.glob('./#{static_dir}/**/*').each do |file|
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
