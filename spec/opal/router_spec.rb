require 'spec_helper'

describe Inesita::Router do
  let(:wrong_router) { Class.new { include Inesita::Router } }
  let(:empty_router) { Class.new { include Inesita::Router; def routes; end } }
  let(:router) do
    Class.new do
      include Inesita::Router

      def routes
      end
    end
  end

  it 'should fail without routes' do
    expect { wrong_router.new }.to raise_error Inesita::Error
  end

  it 'should fail with empty routes' do
    expect { empty_router.new }.to raise_error Inesita::Error
  end
end
