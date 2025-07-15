class NotifyApplicationJob < ApplicationJob
  queue_as :default

  def perform(application_id)
    application = JobApplication.find(application_id)
    job_seeker = application.job_seeker
    opportunity = application.opportunity
    client = opportunity.client

    JobSeekerMailer.with(job_seeker:, opportunity:)
                   .application_received
                   .deliver_later

    ClientMailer.with(client:, opportunity:, job_seeker:)
                .new_application_received
                .deliver_later
  end
end
