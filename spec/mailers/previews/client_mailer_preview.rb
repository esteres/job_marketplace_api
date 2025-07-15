# Preview all emails at http://localhost:3000/rails/mailers/client_mailer_mailer
class ClientMailerPreview < ActionMailer::Preview
  def new_application_received
    client = Client.first || Client.new(name: "Acme Corp", email: "client@example.com")
    job_seeker = JobSeeker.first || JobSeeker.new(name: "Jane Doe", email: "jobseeker@example.com")
    opportunity = Opportunity.first || Opportunity.new(title: "Ruby Developer", client: client)

    ClientMailer.with(client: client, opportunity: opportunity, job_seeker: job_seeker).new_application_received
  end
end
