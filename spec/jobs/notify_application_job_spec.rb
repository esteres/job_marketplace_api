require 'rails_helper'

RSpec.describe NotifyApplicationJob, type: :job do
  let(:client)       { create(:client, email: "client@example.com") }
  let(:job_seeker)   { create(:job_seeker, email: "seeker@example.com") }
  let(:opportunity)  { create(:opportunity, client:) }
  let(:application)  { create(:job_application, job_seeker:, opportunity:) }

  before do
    allow(JobSeekerMailer).to receive_message_chain(:with, :application_received, :deliver_later)
    allow(ClientMailer).to receive_message_chain(:with, :new_application_received, :deliver_later)
  end

  it "sends application received email to job seeker and client" do
    described_class.new.perform(application.id)

    expect(JobSeekerMailer).to have_received(:with).with(
      job_seeker:,
      opportunity:
    )

    expect(ClientMailer).to have_received(:with).with(
      client:,
      opportunity:,
      job_seeker:
    )
  end
end
