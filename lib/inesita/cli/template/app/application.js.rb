require 'virtual-dom'
require 'opal'
require 'browser'
require 'inesita'

require_tree './components'

$document.ready do
  Inesita::Application.new(
    routes: {
      '/' => Home,
      '/welcome' => Welcome,
      '/goodbye' => Goodbye
    },
    layout: Layout
  ).mount($document.body)
end
