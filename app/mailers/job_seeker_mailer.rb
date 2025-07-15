class JobSeekerMailer < ApplicationMailer
  def application_received
    @job_seeker = params[:job_seeker]
    @opportunity = params[:opportunity]

    mail(to: @job_seeker.email, subject: "Your application for #{@opportunity.title} was received")
  end
end
