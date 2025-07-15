require 'rails_helper'

RSpec.describe "Api::V1::Opportunities", type: :request do
  let!(:client) { create(:client) }
  let!(:job_seeker) { create(:job_seeker) }

  let!(:op1) { create(:opportunity, title: "Backend Engineer", client:) }
  let!(:op2) { create(:opportunity, title: "Frontend Engineer", client:) }

  describe "GET /api/v1/opportunities" do
    it "returns all opportunities" do
      get "/api/v1/opportunities"

      expect(response).to have_http_status(:ok)

      expect(response_body["data"].length).to eq(2)
      expect(response_body["data"].first["client"]["name"]).to eq(client.name)
      expect(response_body["meta"]).to include("page", "count", "first_url", "last_url")
    end

    it "returns filtered opportunities by title" do
      get "/api/v1/opportunities", params: { search: "Backend" }

      expect(response).to have_http_status(:ok)

      expect(response_body["data"].length).to eq(1)
      expect(response_body["data"].first["title"]).to eq("Backend Engineer")
    end
  end

  describe "POST /api/v1/opportunities" do
    let(:valid_params) do
      {
        client_id: client.id,
        opportunity: {
          title: "Data Engineer",
          description: "Work with large data sets",
          salary: 100000
        }
      }
    end

    let(:invalid_params) do
      {
        client_id: client.id,
        opportunity: {
          title: "",
          description: "",
          salary: nil
        }
      }
    end

    it "creates an opportunity" do
      post "/api/v1/opportunities", params: valid_params

      expect(response).to have_http_status(:created)

      expect(response_body["title"]).to eq("Data Engineer")
      expect(response_body["salary"]).to eq(100000)
    end

    it "returns error for invalid params" do
      post "/api/v1/opportunities", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_body["errors"]).to include("Title can't be blank", "Description can't be blank", "Salary can't be blank")
    end
  end

  describe "POST /api/v1/opportunities/:id/apply" do
    it "allows job seeker to apply" do
      expect {
        post "/api/v1/opportunities/#{op1.id}/apply", params: { job_seeker_id: job_seeker.id }
      }.to change(JobApplication, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(response_body["message"]).to eq("Application submitted")
    end
  end
end
