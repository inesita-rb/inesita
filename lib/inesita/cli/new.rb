class InesitaCLI < Thor
  include Thor::Actions

  check_unknown_options!

  namespace :new

  desc "new PROJECT_NAME", "Create Inesita app"

  method_option :force,
                aliases: ['-f'],
                default: false,
                desc: 'force overwrite'

  def new(project_dir)
    empty_directory project_dir, force: options[:force]
    copy_file       'template/.gitignore', File.join(project_dir, '.gitignore'), force: options[:force]
    copy_file       'template/config.ru', File.join(project_dir, 'config.ru'), force: options[:force]
    copy_file       'template/Gemfile', File.join(project_dir, 'Gemfile'), force: options[:force]

    empty_directory File.join(project_dir, 'app'), force: options[:force]
    copy_file       'template/app/index.html.slim', File.join(project_dir, 'app', 'index.html.slim'), force: options[:force]
    copy_file       'template/app/application.js.rb', File.join(project_dir, 'app', 'application.js.rb'), force: options[:force]
    copy_file       'template/app/application.css.sass', File.join(project_dir, 'app', 'application.css.sass'), force: options[:force]

    empty_directory File.join(project_dir, 'app', 'components'), force: options[:force]
    copy_file       'template/app/components/welcome_component.rb', File.join(project_dir, 'app', 'components', 'welcome_controller.rb'), force: options[:force]

    inside project_dir do
      run 'bundle install'
    end
  end

  def self.source_root
    File.dirname(__FILE__)
  end
end
