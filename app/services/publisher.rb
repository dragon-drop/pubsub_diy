class Publisher
  def self.subscribe(listener, events)
    @subscribers ||= {}
    events.each do |event|
      @subscribers[event] ||= []
      @subscribers[event] << listener
    end
  end
  def self.publish(event_key)
    # do something to create the event blah blah
    @subscribers[event_key]&.each do |subscriber|
      subscriber.send("publisher_#{event_key}")
    end
  end
end
