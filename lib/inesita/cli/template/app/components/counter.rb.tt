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
    div.input_group do
      span.input_group_btn do
        button.btn.btn_default onclick: method(:dec) do
          text '-'
        end
      end
      input.form_control type: "text", value: store.counter, disabled: true
      span.input_group_btn do
        button.btn.btn_default onclick: method(:inc) do
          text '+'
        end
      end
    end
  end
end
