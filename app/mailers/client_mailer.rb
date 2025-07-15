class ClientMailer < ApplicationMailer
  def new_application_received
    @client = params[:client]
    @opportunity = params[:opportunity]
    @job_seeker = params[:job_seeker]

    mail(to: @client.email, subject: "New application for #{@opportunity.title}")
  end
end
