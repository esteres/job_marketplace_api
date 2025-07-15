module Opportunities
  class CreateService < BaseService
    attr_reader :params, :client_id

    def initialize(client_id:, params:)
      @client_id = client_id
      @params = params
    end

    def call
      client = Client.find(client_id)
      opportunity = client.opportunities.new(params)

      if opportunity.save
        Result.success(opportunity)
      else
        Result.failure(opportunity.errors.full_messages)
      end
    end
  end
end
