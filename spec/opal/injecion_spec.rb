require 'spec_helper'

describe Inesita::Injection do
  let(:application) { Inesita::Application }
  let(:injection) { Class.new { include Inesita::Injection } }
  let(:layout) { Class.new { include Inesita::Layout } }

  it 'should respond to #render!' do
    expect(injection.new).to respond_to(:render!)
  end

  it 'should respond to #root_component' do
    expect(injection.new).to respond_to(:root_component)
  end

  it 'should respond to injection name method' do
    expect(application.new(layout: layout, test: injection)).to respond_to(:test)
  end
end
