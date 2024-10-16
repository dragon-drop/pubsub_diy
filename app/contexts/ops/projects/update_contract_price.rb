module Ops
  module Projects
    class UpdateContractPrice
      def self.call(project, contract_price:, publisher: ProjectPublisher)
        project.update!(contract_price: contract_price)
        publisher.publish(:contract_price_set, record: project)
      end
    end
  end
end
