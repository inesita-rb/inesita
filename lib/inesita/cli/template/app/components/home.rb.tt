class Home
  include Inesita::Component

  def render
    div.jumbotron.text_center.bg_light do
      img src: '/static/inesita-rb.png'
      h1 do
        text "Hello I'm Inesita"
      end
      component Counter, props: {header: 'This is a sample counter'}
    end
  end
end
