module Opportunities
  class SearchService < BaseService
    include Pagy::Backend

    attr_reader :search, :page, :salary

    def initialize(search:, page:, salary: nil)
      @search = search
      @page = page || 1
      @salary = salary
    end

    def call
      cache_key = "opportunities/#{search}-#{page}-#{salary}"

      pagy, records = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
        scope = Opportunity.includes(:client)

        if search.present?
          scope = scope.joins(:client)
                       .where("opportunities.title ILIKE :q OR clients.name ILIKE :q", q: "%#{search}%")
        end

        scope = scope.where(salary: salary) if salary.present?

        pagy(scope, page: page)
      end

      Result.success([ pagy, records ])
    rescue => e
      Result.failure(e.message)
    end
  end
end
