class NavBar
  include Inesita::Component

  def render
    nav class: 'navbar navbar-default' do
      div class: 'container' do
        div class: 'navbar-header' do
          span class: 'navbar-brand' do
            text 'Inesita'
          end
          ul class: 'nav navbar-nav' do
            li class: "#{"active" if url == '/'}" do
              a href: '/' do
                text 'Home'
              end
            end
            li class: "#{"active" if url == '/welcome'}" do
              a href: '/welcome' do
                text 'Welcome'
              end
            end
            li class: "#{"active" if url == '/goodbye'}" do
              a href: '/goodbye' do
                text 'Goodbye'
              end
            end
          end
        end
      end
    end
  end
end
