class InesitaCLI < Thor
  include Thor::Actions

  check_unknown_options!

  namespace :build

  desc 'build [OPTIONS]', 'Build Inesita app'

  method_option :force,
                aliases: :f,
                default: false,
                desc: 'force overwrite'

  method_option :destination_dir,
                aliases: :d,
                default: Inesita::Config::BUILD_DIR,
                desc: 'destination directory'

  method_option :source_dir,
                aliases: :s,
                default: Inesita::Config::APP_DIR,
                desc: 'source (app) dir'

  method_option :static_dir,
                aliases: :t,
                default: Inesita::Config::STATIC_DIR,
                desc: 'static dir'

  method_option :dist_source_dir,
                aliases: :b,
                default: Inesita::Config::APP_DIST_DIR,
                desc: 'source (app) dir for dist build'

  def build
    assets = assets_server
    empty_directory options[:destination_dir], force: options[:force]

    copy_static
    create_asset(assets, 'index.html',     ->(s) { Inesita::Minify.html(s) })
    create_asset(assets, 'application.js', ->(s) { Inesita::Minify.js(s) })
    create_asset(assets, 'stylesheet.css', ->(s) { Inesita::Minify.css(s) })
  end

  no_commands do
    def assets_server
      Inesita::Server.new({
        dist: true,
        static_dir: options[:static_dir],
        app_dir: options[:source_dir],
        app_dist_dir: options[:app_dist_dir]
      }).assets_app
    end

    def copy_static
      destination_dir = options[:destination_dir]
      force = options[:force]
      static_dir = options[:static_dir]

      Dir.glob("./#{static_dir}/**/*").each do |file|
        if File.directory?(file)
          empty_directory File.join(destination_dir, file), force: force
        else
          copy_file File.absolute_path(file), File.join(destination_dir, file.gsub(static_dir, 'static')), force: force
        end
      end
    end

    def create_asset(assets, name, minify_proc)
      create_file File.join(options[:destination_dir], name),
                  minify_proc.call(assets[name].source),
                  force: options[:force]
    end
  end
end
