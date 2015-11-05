require 'spec_helper'

describe Inesita::Router do
  let(:wrong_router) { Class.new { include Inesita::Router } }
  let(:empty_router) { Class.new { include Inesita::Router; def routes; end } }
  let(:router) do
    Class.new do
      include Inesita::Router

      class TestComponent
        include Inesita::Component
      end

      class OtherTestComponent
        include Inesita::Component
      end

      def routes
        route '/', to: TestComponent
        route '/other', to: OtherTestComponent
      end
    end
  end

  it 'should fail without routes' do
    expect { wrong_router.new }.to raise_error Inesita::Error
  end

  it 'should fail with empty routes' do
    expect { empty_router.new }.to raise_error Inesita::Error
  end

  it 'should not fail with routes' do
    expect { router.new }.not_to raise_error
  end

  describe '#url_for' do
    it 'should return url for component name' do
      expect(router.new.url_for(:test_component)).to eq '/'
    end

    it 'should return url for component name' do
      expect(router.new.url_for(:other_test_component)).to eq '/other'
    end

    it 'should fail when no route for component' do
      expect { router.new.url_for(:nothing) }.to raise_error Inesita::Error
    end
  end

  describe '#current_url?' do
    it 'should return true for current url' do
      expect(router.new.current_url?(:test_component)).to eq true
    end

    it 'should return false for current url' do
      expect(router.new.current_url?(:other_test_component)).to eq false
    end
  end
end
