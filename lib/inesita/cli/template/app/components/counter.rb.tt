class Counter
  include Inesita::Component

  def inc
    store.increase
    render!
  end

  def dec
    store.decrease
    render!
  end

  def render
    h4 do
      text props[:header]
    end
    div class: 'input-group' do
      span class: 'input-group-btn' do
        button class: 'btn btn-default', onclick: method(:dec) do
          text '-'
        end
      end
      input type: "text", class: "form-control", value: store.counter, disabled: true
      span class: 'input-group-btn' do
        button class: 'btn btn-default', onclick: -> { inc } do
          text '+'
        end
      end
    end
  end
end
