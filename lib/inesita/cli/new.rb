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
    directory('template', project_dir, {
      project_name: project_dir
    })

    inside project_dir do
      run 'bundle install'
    end
  end

  def self.source_root
    File.dirname(__FILE__)
  end
end
