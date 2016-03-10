require 'opal'
Opal.append_path File.expand_path('../../opal', __FILE__)

require 'opal-virtual-dom'
require 'opal-browser'
require 'slim'
require 'sass'

require 'singleton'
require 'listen'
require 'rubame'

require 'inesita/config'
require 'inesita/app_files_listener'
require 'inesita/live_reload'
require 'inesita/server'

module Inesita
  module_function

  def assets_code
    @assets_code
  end

  def assets_code=(code)
    @assets_code = code
  end
end
