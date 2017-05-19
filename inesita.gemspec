Gem::Specification.new do |s|
  s.name        = 'inesita'
  s.version     = '0.7.0'
  s.authors     = ['Michał Kalbarczyk']
  s.email       = 'fazibear@gmail.com'
  s.homepage    = 'http://github.com/inesita-rb/inesita'
  s.summary     = 'Frontend web framework for Opal'
  s.description = 'Frontent web framework for Opal'
  s.license     = 'MIT'
  s.post_install_message = 'Notice! Inesita 0.6.0 includes lots of breaking changes. See documentaion: https://inesita.fazibear.me/'


  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal-sprockets', '~> 0.4.0.0.11.0.rc1.3.1.beta'
  s.add_dependency 'opal-virtual-dom', '~> 0.5.0'
  s.add_dependency 'thor', '~> 0.19'
  s.add_dependency 'rack-rewrite', '~> 1.5'
  s.add_dependency 'listen', '~> 3.0'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'opal-rspec', '~> 0.6.0'
  s.add_development_dependency 'rake', '~> 11.0'
end
