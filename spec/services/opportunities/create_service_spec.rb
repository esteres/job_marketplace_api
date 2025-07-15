require 'rails_helper'

RSpec.describe Opportunities::CreateService, type: :service do
  let(:client) { create(:client) }
  let(:valid_params) do
    {
      title: "New Opportunity",
      description: "Great job role",
      salary: 100_000
    }
  end
  let(:invalid_params) do
    {
      title: "",
      description: "",
      salary: nil
    }
  end

  describe "#call" do
    context "when params are valid" do
      it "creates an opportunity and returns success" do
        service = described_class.new(client_id: client.id, params: valid_params)
        result = service.call

        expect(result).to be_success
        expect(result.data).to be_a(Opportunity)
        expect(result.data.title).to eq("New Opportunity")
        expect(result.data.client_id).to eq(client.id)
      end
    end

    context "when params are invalid" do
      it "returns failure with error messages" do
        service = described_class.new(client_id: client.id, params: invalid_params)
        result = service.call

        expect(result).to be_failure
        expect(result.errors).to include("Title can't be blank", "Description can't be blank", "Salary can't be blank")
      end
    end

    context "when client does not exist" do
      it "raises ActiveRecord::RecordNotFound error" do
        service = described_class.new(client_id: -1, params: valid_params)

        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
