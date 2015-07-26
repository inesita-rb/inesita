require 'opal'
Opal.append_path File.expand_path('../../opal', __FILE__)
Opal.use_gem 'opal-virtual-dom'

require 'slim'
require 'sass'
require 'thor'

require 'inesita/server'
require 'inesita/cli/server'
