require 'virtual-dom'
require 'opal'
require 'browser'
require 'inesita'

require_tree './components'

$document.ready do
  WelcomeComponent.new.mount($document['app'])
end
