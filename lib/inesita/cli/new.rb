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
    Dir.glob("#{File.dirname(__FILE__)}/template/**/*",  File::FNM_DOTMATCH).each do |file|
      next if File.directory?(file)
      path = file.split('/')
      copy_file file, File.join(project_dir, path[path.index('template')+1..-1].join('/')), force: options[:force]
    end

    inside project_dir do
      run 'bundle install'
    end
  end

  def self.source_root
    File.dirname(__FILE__)
  end
end
