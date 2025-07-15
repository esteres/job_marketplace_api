require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  describe 'associations' do
    it { should belong_to(:job_seeker) }
    it { should belong_to(:opportunity).counter_cache(true) }
  end

  describe 'counter cache' do
    it 'increments job_applications_count on opportunity' do
      opportunity = create(:opportunity, job_applications_count: 0)

      expect {
        create(:job_application, opportunity:)
      }.to change { opportunity.reload.job_applications_count }.by(1)
    end
  end
end
