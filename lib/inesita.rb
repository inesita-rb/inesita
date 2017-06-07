require 'opal-sprockets'
Opal.append_path File.expand_path('../../opal', __FILE__)

require 'opal-virtual-dom'

require 'listen'

require 'inesita/config'
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
