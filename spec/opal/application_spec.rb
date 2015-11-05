require 'spec_helper'

describe Inesita::Application do
  let(:application) { Inesita::Application }
  let(:router) { Class.new { include Inesita::Router } }
  let(:layout) { Class.new { include Inesita::Layout } }
  let(:store) { Class.new { include Inesita::Store } }

  it 'should respond to #render' do
    expect(application.new(router: router)).to respond_to(:render)
  end

  it 'should fail without :router' do
    expect { application.new }.to raise_error
  end

  it 'should fail with wrong :router class' do
    expect { application.new(router: Class) }.to raise_error
  end

  it 'should not fail with :router class' do
    expect { application.new(router: router) }.to_not raise_error
  end

  it 'should fail with wrong :layout class' do
    expect { application.new(layout: Class) }.to raise_error
  end

  it 'should not fail with :layout class' do
    expect { application.new(layout: layout) }.to raise_error
  end

  it 'should fail with wrong :store class' do
    expect { application.new(store: Class) }.to raise_error
  end

  it 'should not fail with :layout class' do
    expect { application.new(store: store) }.to raise_error
  end
end
