# initialize bundler
require 'bundler'
Bundler.require

# setup slim templates
def setup(sprockets)
  sprockets.register_engine(
    '.slim',
    Slim::Template,
    silence_deprecation: true
  )
end

# you can comment this line to disable live-reload
use Inesita::LiveReload

# run inesita server
run Inesita::Server.new(setup_sprockets: method(:setup))
