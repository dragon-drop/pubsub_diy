require_relative "../../app/contexts/activity_feeds/initializer"

Rails.application.config.after_initialize do
  ActivityFeeds::Configuration.start
end
