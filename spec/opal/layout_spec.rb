require 'spec_helper'

describe Inesita::Layout do
  let(:store) { Class.new { include Inesita::Layout } }

  it 'should respond to #outlet' do
    expect(store.new).to respond_to(:outlet)
  end
end
