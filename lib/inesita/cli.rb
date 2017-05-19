require 'thor'

begin
  require 'bundler'
  Bundler.require
rescue Bundler::GemfileNotFound
  require 'opal-virtual-dom'
  require 'inesita/server'
end

require 'rack'
require 'inesita/config'
require 'inesita/minify'
require 'inesita/cli/build'
require 'inesita/cli/server'
require 'inesita/cli/new'
require 'inesita/cli/watch'
