module Inesita
  module Dispatcher
    class Subscriber
      attr_reader :action_name, :callback

      def initialize(action_name, &block)
        @action_name = action_name
        @callback = block
      end
    end

    def subscribe(action_name, &block)
      @subscribers ||= []
      @subscribers << Subscriber.new(action_name.to_sym, &block)
    end

    def action(action_name, payload = {})
      fail Error "Unknown action #{action_name}" unless actions.include?(action_name)
      @subscribers ||= []
      @subscribers.select { |i| i.action_name == action_name.to_sym }.each do |subscriber|
        subscriber.callback.call(payload)
      end
    end
  end
end
