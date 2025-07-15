module Opportunities
  class ApplyService  < BaseService
    attr_reader :opportunity_id, :job_seeker_id

    def initialize(opportunity_id:, job_seeker_id:)
      @opportunity_id = opportunity_id
      @job_seeker_id = job_seeker_id
    end

    def call
      opportunity = Opportunity.find(opportunity_id)
      job_seeker = JobSeeker.find(job_seeker_id)

      application = opportunity.job_applications.create!(job_seeker:)
      NotifyApplicationJob.perform_later(application.id)

      application
    end
  end
end
