module Inesita
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :new

    desc 'new PROJECT_NAME', 'Create Inesita app'

    method_option :force,
                  aliases: :f,
                  type: :boolean,
                  default: false,
                  desc: 'force overwrite'

    def new(project_dir)
      directory('template', project_dir, project_name: project_dir, build_dir: Inesita::Config::BUILD_DIR)

      inside project_dir do
        run 'bundle install'
      end
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end
end
