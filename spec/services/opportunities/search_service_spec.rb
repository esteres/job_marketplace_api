require 'rails_helper'

RSpec.describe Opportunities::SearchService, type: :service do
  include Pagy::Backend

  let!(:client1) { create(:client, name: "Acme Corp") }
  let!(:client2) { create(:client, name: "SpaceX") }

  let!(:op1) { create(:opportunity, title: "Software Engineer", client: client1) }
  let!(:op2) { create(:opportunity, title: "Backend Developer", client: client2) }
  let!(:op3) { create(:opportunity, title: "HR Manager", client: client2) }

  before { Rails.cache.clear }

  describe ".call" do
    context "without search param" do
      it "returns paginated opportunities" do
        result = described_class.call(search: nil, page: 1)

        expect(result).to be_a(Result)
        expect(result).to be_success

        pagy, records = result.data

        expect(records.count).to eq(3)
        expect(pagy.page).to eq(1)
      end
    end

    context "with title search" do
      it "returns matching opportunities by title" do
        result = described_class.call(search: "Engineer", page: 1)

        expect(result).to be_success
        pagy, records = result.data

        expect(records).to include(op1)
        expect(records).not_to include(op2, op3)
      end
    end

    context "with client name search" do
      it "returns matching opportunities by client name" do
        result = described_class.call(search: "SpaceX", page: 1)

        expect(result).to be_success
        _, records = result.data

        expect(records).to match_array([ op2, op3 ])
      end
    end

    context "with caching" do
      it "writes to cache with correct key" do
        key = "opportunities/Engineer-1-"
        expect(Rails.cache.exist?(key)).to be false

        described_class.call(search: "Engineer", page: 1)

        expect(Rails.cache.exist?(key)).to be true
      end
    end
  end
end
