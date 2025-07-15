require "rails_helper"

RSpec.describe JobSeekerMailer, type: :mailer do
  describe "#application_received" do
    let(:job_seeker) { create(:job_seeker, email: "applicant@example.com") }
    let(:opportunity) { create(:opportunity, title: "Ruby Developer") }
    let(:mail) { described_class.with(job_seeker:, opportunity:).application_received }

    it "renders the headers" do
      expect(mail.subject).to eq("Your application for Ruby Developer was received")
      expect(mail.to).to eq([ job_seeker.email ])
      expect(mail.from).to eq([ "from@example.com" ])
    end

    it "includes opportunity title and job seeker name in the body" do
      expect(mail.body.encoded).to match("Ruby Developer")
      expect(mail.body.encoded).to match("#{job_seeker.name}")
    end
  end
end
