Gem::Specification.new do |s|
  s.name        = 'inesita'
  s.version     = '1.0.pre.5'
  s.authors     = ['Michał Kalbarczyk']
  s.email       = 'fazibear@gmail.com'
  s.homepage    = 'http://github.com/inesita-rb/inesita'
  s.summary     = 'Frontend web framework for Opal'
  s.description = 'Frontent web framework for Opal'
  s.license     = 'MIT'
  s.post_install_message = 'Thanks for using princess Inesita. See documentaion: https://inesita.fazibear.me/'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal', '~> 1.0'
  s.add_dependency 'opal-virtual-dom', '~> 0.6.1'
  s.add_dependency 'thor', '~> 1.2'
  s.add_dependency 'rack', '~> 2.0'
  s.add_dependency 'listen', '~> 3.0'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'opal-rspec', '~> 1.0'
  s.add_development_dependency 'rake', '~> 13.0'
end
