# Preview all emails at http://localhost:3000/rails/mailers/job_seeker_mailer_mailer
class JobSeekerMailerPreview < ActionMailer::Preview
  def application_received
    job_seeker = JobSeeker.first || JobSeeker.new(name: "Esteban Restrepo", email: "jobseeker@example.com")
    opportunity = Opportunity.first || Opportunity.new(title: "Ruby Developer")

    JobSeekerMailer.with(job_seeker:, opportunity:).application_received
  end
end
