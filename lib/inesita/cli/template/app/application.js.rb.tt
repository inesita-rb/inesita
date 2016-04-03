# require Inesita
require 'inesita'

# require main parts of application
require 'router'
require 'store'
require 'layout'

# require all components
require_tree './components'

# when document is ready render application to <body>
Inesita::Browser.ready? do
  # setup Inesita application
  Inesita::Application.new(
    router: Router,
    store: Store,
    layout: Layout
  ).mount_to(Inesita::Browser.body)
end
