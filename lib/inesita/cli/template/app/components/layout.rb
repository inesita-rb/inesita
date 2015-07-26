class Layout
  include Inesita::Layout

  component :navbar, NavBar.new

  def render
    div do
      div class: 'container' do
        component navbar
        component outlet
      end
    end
  end
end
