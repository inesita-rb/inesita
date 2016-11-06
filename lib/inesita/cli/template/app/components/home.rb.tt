class Home
  include Inesita::Component

  def render
    div.jumbotron class: 'text-center' do
      img src: '/static/inesita-rb.png'
      h1 do
        text "Hello I'm Inesita"
      end
      component Counter, props: {header: 'This is a sample counter'}
    end
  end
end
