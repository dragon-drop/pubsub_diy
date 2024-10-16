require_relative "../../app/services/publisher"

unless defined?(Ops::ProjectPublisher)
  module Ops
    class ProjectPublisher < Publisher
      record_name :project
    end
  end
end

RSpec.describe Publisher do
  subject(:publisher) { Ops::ProjectPublisher }

  # Arguments
  let(:record) { instance_double("Project") }
  let(:event_key) { :subscribed_event }

  # Dependencies
  let(:event_factory) { class_double("Event") }
  let(:subscriber) { double("Subscriber") }

  # Results
  let(:event) { instance_double("Event") }

  before do
    allow(event_factory).to receive(:create).and_return(event)
    allow(subscriber).to receive(:ops_project_subscribed_event)
    allow(subscriber).to receive(:ops_project_unsubscribed_event)
  end

  describe '#publish' do
    subject(:publish) { publisher.publish(event_key, record: record, user_id: 1, event_factory: event_factory) }

    it "creates an event in the database" do
      publish
      expect(event_factory).to have_received(:create).with(key: "project_subscribed_event", record:, user_id: 1)
    end

    context "with an event that has been subscribed to" do
      subject(:publisher)  { Ops::ProjectPublisher }

      it "calls the method on the subscriber based on the current class and module name with the event" do
        publisher.subscribe(subscriber, [ :subscribed_event ])
        publish
        expect(subscriber).to have_received(:ops_project_subscribed_event).with(event)
      end
    end
    context "without a subscriber to the event" do
      let(:event_key) { :unsubscribed_event }

      it "does not call the method on the subscriber if the event has not been subscribed to" do
        publish
        expect(subscriber).not_to have_received(:ops_project_unsubscribed_event)
      end
    end
  end
end
