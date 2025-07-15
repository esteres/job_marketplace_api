require 'rails_helper'

RSpec.describe Opportunities::ApplyService, type: :service do
  let!(:client) { create(:client) }
  let!(:opportunity) { create(:opportunity, client: client) }
  let!(:job_seeker) { create(:job_seeker) }

  describe "#call" do
    context "when opportunity and job seeker exist" do
      it "creates a job application and enqueues notification" do
        service = described_class.new(opportunity_id: opportunity.id, job_seeker_id: job_seeker.id)

        expect {
          @application = service.call
        }.to change(JobApplication, :count).by(1)

        expect(@application.opportunity).to eq(opportunity)
        expect(@application.job_seeker).to eq(job_seeker)

        expect(NotifyJobSeekerJob).to have_been_enqueued.with(@application.id)
      end
    end

    context "when opportunity does not exist" do
      it "raises ActiveRecord::RecordNotFound" do
        service = described_class.new(opportunity_id: -1, job_seeker_id: job_seeker.id)
        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when job seeker does not exist" do
      it "raises ActiveRecord::RecordNotFound" do
        service = described_class.new(opportunity_id: opportunity.id, job_seeker_id: -1)
        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
