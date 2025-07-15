require "rails_helper"

RSpec.describe ClientMailer, type: :mailer do
  describe "#new_application_received" do
    let(:client) { create(:client, email: "client@example.com") }
    let(:job_seeker) { create(:job_seeker, name: "Esteban Restrepo") }
    let(:opportunity) { create(:opportunity, title: "Backend Developer", client:) }

    let(:mail) { described_class.with(client:, opportunity:, job_seeker:).new_application_received.deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("New application for Backend Developer")
      expect(mail.to).to eq([ client.email ])
      expect(mail.from).to eq([ "from@example.com" ])
    end

    it "includes opportunity title and job seeker name in the body" do
      expect(mail.body.encoded).to match("Backend Developer")
      expect(mail.body.encoded).to match("Esteban Restrepo")
    end
  end
end
