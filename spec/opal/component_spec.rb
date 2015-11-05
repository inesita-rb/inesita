require 'spec_helper'

describe Inesita::Router do
  let(:empty_component) { Class.new { include Inesita::Component }}
  let(:component) do
    Class.new do
      include Inesita::Component

      def render
        h1 class: 'test' do
          'Test'
        end
      end
    end
  end

  let(:element) do
    $document.create_element('div')
  end

  it 'should fail when no #render method' do
    expect { empty_component.new.mount_to(element) }.to raise_error Inesita::Error
  end

  it 'should render html' do
    component.new.mount_to(element)
    expect(element.inner_html).to eq '<h1 class="test">Test</h1>'
  end
end
