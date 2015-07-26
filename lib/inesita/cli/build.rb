class InesitaCLI < Thor

  check_unknown_options!

  namespace :build

  desc "build [OPTIONS]", "Build Inesita app"

  def build
    puts 'building'
  end
end
