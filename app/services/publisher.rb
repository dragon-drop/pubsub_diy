class Publisher
  def self.record_name(name)
    @record_name = name
  end

  def self.subscribe(listener, events)
    @subscribers ||= {}
    events.each do |event|
      @subscribers[event] ||= []
      @subscribers[event] << listener
    end
  end
  def self.publish(event_key, record:, user_id: nil, event_factory: Event)
    event = event_factory.create(key: "#{@record_name}_#{event_key}", record: record, user_id: user_id)
    fetch_subcribers(event_key).each do |subscriber|
      subscriber.send("#{prefix}_#{event_key}", event)
    end
  end

  def self.prefix
    self.name.split("::").map(&:downcase).map { |name| name.gsub("publisher", "") }.join("_")
  end

  def self.fetch_subcribers(event_key)
    return [] if @subscribers.nil?
    return [] if @subscribers[event_key].nil?
    @subscribers[event_key]
  end
end
