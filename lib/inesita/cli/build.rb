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
    assets = assets_server

    empty_directory build_dir, force: force

    copy_static
    create_index(assets)
    create_js(assets)
    create_css(assets)
  end

  no_commands do
    def assets_server
      Inesita::Server.new({
        dist: true,
        static_dir: options[:static_dir],
        app_dir: options[:app_dir],
        app_dist_dir: options[:app_dist_dir]
      }).assets_app
    end

    def copy_static
      Dir.glob("./#{options[:static_dir]}/**/*").each do |file|
        if File.directory?(file)
          empty_directory File.join(options[:destination_dir], file), force: options[:force]
        else
          copy_file File.absolute_path(file), File.join(options[:destination_dir], file), force: options[:force]
        end
      end
    end

    def create_index(assets)
      create_file File.join(options[:destination_dir], 'index.html'),
                  Inesita::Minify.html(assets['index.html'].source),
                  force: options[:force]
    end

    def create_js(assets)
      create_file File.join(options[:destination_dir], 'application.js'),
                  Inesita::Minify.js( assets['application.js'].source),
                  force: options[:force]
    end

    def create_css(assets)
      create_file File.join(options[:destination_dir], 'stylesheet.css'),
                  Inesita::Minify.css( assets['stylesheet.css'].source),
                  force: options[:force]
    end
  end
end
