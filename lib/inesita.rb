require 'opal'
Opal.append_path File.expand_path('../../opal', __FILE__)

# TODO: wait for opal fix
# Opal.use_gem 'opal-virtual-dom'

require 'opal-virtual-dom'
require 'slim'
require 'sass'

require 'inesita/server'

module Inesita
  module_function

  def env
    @env || :development
  end

  def env=(env)
    @env = env
  end

  def assets_code
    @assets_code
  end

  def assets_code=(code)
    @assets_code = code
  end
end
