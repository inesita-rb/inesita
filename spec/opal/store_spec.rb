require 'spec_helper'

describe Inesita::Store do
  let(:store) { Class.new { include Inesita::Store } }

  it 'should respond to #store' do
    expect(store.new).to respond_to(:store)
  end

  it 'should respond to #render!' do
    expect(store.new).to respond_to(:render!)
  end

  it 'should respond to #with_root_component' do
    expect(store.new).to respond_to(:with_root_component)
  end
end
