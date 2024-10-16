# This is where we setup event listening

module ActivityFeeds
  class Configuration
    def self.start
      Ops::ProjectPublisher.subscribe(Projects::ProjectsListener.new, [ :ops_project_contract_price_set ])
    end
  end
end
