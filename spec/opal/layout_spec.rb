require 'spec_helper'

describe Inesita::Layout do
  let(:layout) { Class.new { include Inesita::Layout } }

  it 'should respond to #outlet' do
    expect(layout.new).to respond_to(:outlet)
  end
end
