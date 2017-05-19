# initialize bundler
require 'bundler'
Bundler.require

# setup slim templates
class SlimTransformer
  def self.call(input)
    Slim::Template.new(input[:name]) { input[:data] }.render(nil)
  end
end

def setup(sprockets)
  if sprockets.respond_to?(:register_transformer)
    sprockets.register_mime_type 'text/html', extensions: ['.slim', '.html.slim', '.slim.html']
    sprockets.register_preprocessor 'text/html', SlimTransformer
  elsif sprockets.respond_to?(:register_engine)
    sprockets.register_engine '.slim', Slim::Template
  end
end

# you can comment this line to disable live-reload
use Inesita::LiveReload

# run inesita server
run Inesita::Server.new(setup_sprockets: method(:setup))
