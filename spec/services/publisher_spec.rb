require_relative "../../app/services/publisher"

RSpec.describe Publisher do
  let(:publisher) { Publisher }

  describe '#publish' do
    context "with an event that has been subscribed to" do
      let(:subscriber) { double("Subscriber") }
      before do
        allow(subscriber).to receive(:publisher_subscribed_event)
        allow(subscriber).to receive(:publisher_unsubscribed_event)
      end
      it "calls the method on the subscriber based on the current class and module name" do
        publisher.subscribe(subscriber, [ :subscribed_event ])
        publisher.publish(:subscribed_event)
        expect(subscriber).to have_received(:publisher_subscribed_event)
      end

      it "does not call the method on the subscriber if the event has not been subscribed to" do
        publisher.publish(:unsubscribed_event)
        expect(subscriber).not_to have_received(:publisher_unsubscribed_event)
      end
    end
  end
end
