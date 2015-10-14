Gem::Specification.new do |s|
  s.name        = 'inesita'
  s.version     = '0.2.2'
  s.authors     = [ 'Michał Kalbarczyk' ]
  s.email       = 'fazibear@gmail.com'
  s.homepage    = 'http://github.com/inesita-rb/inesita'
  s.summary     = 'Frontend web framework for Opal'
  s.description = 'Frontent web framework for Opal'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal', '~> 0.8'
  s.add_dependency 'opal-virtual-dom', '~> 0.1.0'
  s.add_dependency 'slim', '~> 3.0'
  s.add_dependency 'sass', '~> 3.4'
  s.add_dependency 'thor', '~> 0.19'
  s.add_dependency 'rack-rewrite', '~> 1.5'
  s.add_development_dependency 'rake', '~> 10.4'
end
