class NotifyApplicationJob
  include Sidekiq::Job

  def perform(application_id)
    application = JobApplication.find(application_id)
    job_seeker = application.job_seeker
    opportunity = application.opportunity
    client = opportunity.client

    JobSeekerMailer.with(job_seeker: job_seeker, opportunity: opportunity)
                   .application_received
                   .deliver_later

    ClientMailer.with(client: client, opportunity: opportunity, job_seeker: job_seeker)
                .new_application_received
                .deliver_later
  end
end
