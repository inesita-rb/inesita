require 'virtual-dom'
require 'opal'
require 'browser'
require 'inesita'

require 'components/navbar'
require 'components/layout'
require 'components/home'
require 'components/welcome'
require 'components/goodbye'

$document.ready do
  Inesita::Application.new(
    routes: {
      '/' => Home,
      '/welcome' => Welcome,
      '/goodbye' => Goodbye
    },
    mount: $document.body,
    layout: Layout
  ).run
end
