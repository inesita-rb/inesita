class Layout
  include Inesita::Layout

  def initialize
    component :navbar, NavBar.new
  end

  def render
    div do
      div class: 'container' do
        component navbar
        component outlet
      end
    end
  end
end
