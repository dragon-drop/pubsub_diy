module ActivityFeeds
  module Projects
    class ProjectsListener
      def ops_project_contract_price_set(event)
        puts "Project contract price set: #{event.record.contract_price}"
      end
    end
  end
end
